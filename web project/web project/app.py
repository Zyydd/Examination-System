from flask import Flask, request, render_template, jsonify, session, redirect, url_for
import pyodbc
import datetime
import random

app = Flask(__name__)
app.secret_key = 'your-secret-key-here'  # Replace in production

# Database configuration
DB_CONFIG = {
    'driver': '{ODBC Driver 17 for SQL Server}',
    'server': 'localhost',
    'database': 'Graduation_Project_OLTP',
    'uid': 'ahmed',
    'pwd': 'ahmed2025'
}

class ExamSystem:
    def __init__(self):
        self.connection = None

    def connect_db(self):
        try:
            conn_str = (
                f"DRIVER={DB_CONFIG['driver']};"
                f"SERVER={DB_CONFIG['server']};"
                f"DATABASE={DB_CONFIG['database']};"
                f"UID={DB_CONFIG['uid']};"
                f"PWD={DB_CONFIG['pwd']}"
            )
            self.connection = pyodbc.connect(conn_str)
            print(f"✅ Connected to DB: {DB_CONFIG['database']}")
            return True
        except Exception as e:
            print(f"❌ Database connection error: {e}")
            return False

    def close_db(self):
        if self.connection:
            self.connection.close()

    def get_courses(self):
        try:
            cursor = self.connection.cursor()
            cursor.execute("SELECT Course_Name FROM Courses")
            courses = [row[0] for row in cursor.fetchall()]
            return courses
        except Exception as e:
            print(f"❌ Error fetching courses: {e}")
            return []
        finally:
            cursor.close()

    def sp_generate_exam_on_login(self, email, password, course_name):
        try:
            cursor = self.connection.cursor()
            # Check email and password
            cursor.execute("SELECT St_ID, Fname, Lname, password ,Email FROM Student WHERE Email = ?", (email,))
            row = cursor.fetchone()
            if not row:
                return {"error": "Student not found. Please check your email."}

            if row[3] != password:
                return {"error": "Incorrect password. Please try again."}

            student = {"St_ID": row[0], "Fname": row[1], "Lname": row[2],"Email":row[4]}

            cursor.execute("SELECT Course_ID FROM Courses WHERE Course_Name = ?", (course_name,))
            row = cursor.fetchone()
            if not row:
                return {"error": "Course not found. Please check the course name."}

            course_id = row[0]

            cursor.execute("""
                INSERT INTO Exam (Exam_Name, Exam_Duration, Exam_Mark)
                OUTPUT INSERTED.Exam_ID
                VALUES (?, ?, ?)
            """, (
                course_name,
                "60 minutes",
                100.0
            ))
            exam_id = cursor.fetchone()[0]

            self.connection.commit()

            return {
                "st_id": student["St_ID"],
                "email": student["Email"],
                "course_id": course_id,
                "exam_id": exam_id,
                "student_name": f"{student['Fname']} {student['Lname']}",
                "course_name": course_name
            }

        except Exception as e:
            print(f"❌ Error in sp_generate_exam_on_login: {e}")
            return {"error": str(e)}
        finally:
            cursor.close()

    def sp_start_exam(self, st_id, exam_id):
        try:
            cursor = self.connection.cursor()
            cursor.execute("SELECT Exam_Name FROM Exam WHERE Exam_ID = ?", (exam_id,))
            row = cursor.fetchone()
            if not row:
                return {"error": "Exam not found."}

            base_course = row[0].split(' ')[0]
            cursor.execute("""
                SELECT top (10) q.Question_ID, q.Question_txt, q.Correct_Answer, q.Question_Level, q.Question_Type
                FROM Questions q
                JOIN Courses c ON q.Course_ID = c.Course_ID
                WHERE c.Course_Name LIKE ?
                ORDER BY NEWID();           
            """, (f"%{base_course}%",))
            questions = cursor.fetchall()

            questions_list = []
            for q in questions:
                cursor.execute("SELECT Answer_Choice FROM Answer_Choices WHERE Question_ID = ?", (q[0],))
                choices = [choice[0] for choice in cursor.fetchall()]
                questions_list.append({
                    "Question_ID": q[0],
                    "Question_txt": q[1],
                    "Correct_Answer": q[2],
                    "Question_Level": q[3],
                    "Question_Type": q[4],
                    "choices": choices
                })

            return {"questions": questions_list}

        except Exception as e:
            print(f"❌ Error in sp_start_exam: {e}")
            return {"error": str(e)}
        finally:
            cursor.close()

    def submit_exam(self, st_id, exam_id, course_id, answers):
        try:
            cursor = self.connection.cursor()
            total_questions = len(answers)
            correct_answers = 0

            for question_id, student_answer in answers.items():
                cursor.execute("SELECT Correct_Answer FROM Questions WHERE Question_ID = ?", (question_id,))
                correct = cursor.fetchone()
                is_correct = correct and correct[0] == student_answer
                if is_correct:
                    correct_answers += 1

                grade = 10 if is_correct else 0
                cursor.execute("""
                    INSERT INTO Stud_answers (St_ID, Question_ID, St_Answer, Ques_Grade, Exam_ID)
                    VALUES (?, ?, ?, ?, ?)
                """, (st_id, question_id, student_answer, grade, exam_id))

            percentage = (correct_answers / total_questions) * 100 if total_questions > 0 else 0
            result_status = "Pass" if percentage >= 60 else "Fail"

            cursor.execute("""
                INSERT INTO Exam_Result (St_ID, Exam_ID, Course_ID, Exam_Date, Exam_Percentage, Result)
                VALUES (?, ?, ?, ?, ?, ?)
            """, (st_id, exam_id, course_id, datetime.datetime.now().strftime('%Y-%m-%d'), percentage, result_status))

            self.connection.commit()

            return {
                "total_questions": total_questions,
                "correct_answers": correct_answers,
                "percentage": percentage,
                "result": result_status
            }

        except Exception as e:
            print(f"❌ Error in submit_exam: {e}")
            return {"error": str(e)}
        finally:
            cursor.close()

exam_system = ExamSystem()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/get_courses', methods=['GET'])
def get_courses():
    try:
        if not exam_system.connect_db():
            return jsonify({"error": "Database connection failed"}), 500
        courses = exam_system.get_courses()
        exam_system.close_db()
        return jsonify({"courses": courses})
    except Exception as e:
        print(f"❌ Exception in /get_courses: {e}")
        return jsonify({"error": str(e)}), 500

@app.route('/login', methods=['POST'])
def login():
    try:
        data = request.get_json()
        email = data.get('email', '').strip()
        password = data.get('password', '').strip()
        course_name = data.get('course_name', '').strip()

        if not email or not password or not course_name:
            return jsonify({"error": "Email, password, and course name are required."}), 400

        if not exam_system.connect_db():
            return jsonify({"error": "Database connection failed."}), 500

        result = exam_system.sp_generate_exam_on_login(email, password, course_name)
        exam_system.close_db()

        if "error" in result:
            return jsonify(result), 400

        session['st_id'] = result['st_id']
        session['exam_id'] = result['exam_id']
        session['course_id'] = result['course_id']
        session['student_name'] = result['student_name']
        session['course_name'] = result['course_name']

        return jsonify({"success": True, **result})

    except Exception as e:
        print(f"❌ Exception in /login: {e}")
        return jsonify({"error": str(e)}), 500

@app.route('/start_exam', methods=['POST'])
def start_exam():
    try:
        st_id = session.get('st_id')
        exam_id = session.get('exam_id')

        if not st_id or not exam_id:
            return jsonify({"error": "Session expired. Please login again."}), 401

        if not exam_system.connect_db():
            return jsonify({"error": "Database connection failed."}), 500

        result = exam_system.sp_start_exam(st_id, exam_id)
        exam_system.close_db()

        if "error" in result:
            return jsonify(result), 400

        session['exam_start_time'] = datetime.datetime.now().isoformat()
        return jsonify(result)

    except Exception as e:
        print(f"❌ Exception in /start_exam: {e}")
        return jsonify({"error": str(e)}), 500

@app.route('/submit_exam', methods=['POST'])
def submit_exam():
    try:
        data = request.get_json()
        answers = data.get('answers', {})

        st_id = session.get('st_id')
        exam_id = session.get('exam_id')
        course_id = session.get('course_id')

        if not st_id or not exam_id or not course_id:
            return jsonify({"error": "Session expired. Please login again."}), 401

        if not exam_system.connect_db():
            return jsonify({"error": "Database connection failed."}), 500

        result = exam_system.submit_exam(st_id, exam_id, course_id, answers)
        exam_system.close_db()

        if "error" in result:
            return jsonify(result), 400

        return jsonify(result)

    except Exception as e:
        print(f"❌ Exception in /submit_exam: {e}")
        return jsonify({"error": str(e)}), 500

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)

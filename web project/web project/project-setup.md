# Online Examination System Setup Guide

## Project Overview
This is a complete online examination system built with Python Flask and MySQL, following the exact flow specified in your requirements.

## Project Structure
```
examination-system/
├── app.py                 # Main Flask application
├── exam_procedures.sql    # Database stored procedures
├── templates/            # HTML templates
│   └── index.html        # Main frontend interface
├── static/
│   ├── style.css         # Styling
│   └── app.js           # JavaScript functionality
├── requirements.txt      # Python dependencies
└── README.md            # This file
```

## Prerequisites
- Python 3.8+
- MySQL Server 8.0+
- Web browser (Chrome, Firefox, Safari)

## Installation Steps

### 1. Database Setup
1. Install MySQL Server if not already installed
2. Create the database and tables using your provided schema
3. Run the stored procedures script:
```sql
mysql -u your_username -p Project_OLTP < exam_procedures.sql
```

### 2. Python Environment Setup
1. Create a virtual environment:
```bash
python -m venv exam_env
source exam_env/bin/activate  # On Windows: exam_env\Scripts\activate
```

2. Install required packages:
```bash
pip install -r requirements.txt
```

### 3. Configuration
1. Update database configuration in `app.py`:
```python
DB_CONFIG = {
    'host': 'your_host',
    'database': 'Project_OLTP',
    'user': 'your_username',
    'password': 'your_password'
}
```

2. Change the secret key in `app.py` for production:
```python
app.secret_key = 'your-secure-secret-key-here'
```

## Running the Application

### 1. Start the Flask Server
```bash
python app.py
```
The server will start on `http://localhost:5000`

### 2. Access the Web Interface
Open your browser and navigate to:
- `http://localhost:5000` - Main login page
- The frontend interface will load automatically

## Flow Implementation

The system follows your exact specified flow:

### 1. Login Process
- Student enters email + course name
- System calls `sp_generate_exam_on_login` stored procedure
- Retrieves `st_id` from student table based on email
- Retrieves `course_id` from course name
- Creates new `exam_id`
- Returns exam_id in response

### 2. Exam Start Process
- System stores `st_id` and `exam_id` from login
- When "Start Exam" is clicked, calls `sp_start_exam`
- Uses stored `st_id` and `exam_id` values
- Questions are displayed as created

## Database Schema Integration

The system uses your complete database schema including:
- **Student table**: For authentication via email
- **Courses table**: For course name to ID mapping
- **Questions table**: Question bank storage
- **Answer_Choices table**: Multiple choice options
- **Exam table**: Dynamic exam creation
- **Exam_Ques table**: Exam-question relationships
- **Exam_Result table**: Results storage
- **Stud_answers table**: Student answer tracking

## Key Features

### Frontend Features
- Responsive design for desktop and mobile
- Real-time exam timer
- Question navigation
- Auto-save functionality
- Secure exam environment (prevents cheating)
- Professional UI with modern styling

### Backend Features
- Session management for student tracking
- Stored procedure integration
- Secure database operations
- Error handling and logging
- RESTful API endpoints
- Input validation and sanitization

### Security Features
- SQL injection prevention
- Session-based authentication
- CSRF protection
- Input validation
- Secure exam environment
- Time-based controls

## API Endpoints

- `GET /` - Login page
- `POST /login` - Handle login and exam generation
- `POST /start_exam` - Start exam and get questions
- `POST /submit_exam` - Submit answers and get results
- `GET /logout` - Clear session and logout

## Sample Test Data

The system includes sample data for testing:
- **Students**: john.doe@email.com, jane.smith@email.com
- **Courses**: Database Management, Web Development, Data Structures
- **Questions**: Multiple choice questions for each course

## Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Check MySQL server is running
   - Verify connection credentials
   - Ensure database exists

2. **Stored Procedure Not Found**
   - Run the exam_procedures.sql script
   - Check procedure names match exactly

3. **Session Issues**
   - Clear browser cookies
   - Restart Flask application
   - Check secret key configuration

### Logs and Debugging
- Flask debug mode is enabled by default
- Check console for error messages
- Database errors are logged to console

## Production Deployment

For production deployment:
1. Disable debug mode in Flask
2. Use a proper WSGI server (Gunicorn, uWSGI)
3. Configure proper database connection pooling
4. Set up SSL/HTTPS
5. Configure proper logging
6. Set secure session configuration

## Customization

### Adding New Questions
Use the Questions and Answer_Choices tables to add new questions:
```sql
INSERT INTO Questions (Question_ID, Question_txt, Correct_Answer, Question_Level, Question_Type, Course_ID)
VALUES (6, 'Your question here?', 'Correct answer', 'Medium', 'Multiple Choice', 101);

INSERT INTO Answer_Choices (Question_ID, Answer_Choice)
VALUES (6, 'Option 1'), (6, 'Option 2'), (6, 'Option 3'), (6, 'Option 4');
```

### Modifying Exam Duration
Update the exam duration in the stored procedure or add it as a parameter.

### Adding New Courses
Insert new courses in the Courses table and add corresponding questions.

## Support

For issues or questions regarding the examination system:
1. Check the troubleshooting section
2. Review the database schema
3. Verify stored procedure execution
4. Check Flask application logs

## Version History
- v1.0 - Initial release with complete examination flow
- Implements sp_generate_exam_on_login and sp_start_exam procedures
- Full web interface with modern design
- Complete database integration
// Application state
let currentUser = null;
let currentExam = null;
let examTimer = null;
let currentQuestionIndex = 0;
let userAnswers = [];

// DOM Elements
const pages = {
    login: document.getElementById('login-page'),
    dashboard: document.getElementById('dashboard-page'),
    exam: document.getElementById('exam-page'),
    results: document.getElementById('results-page')
};

document.addEventListener('DOMContentLoaded', function () {
    initializeApp();
});

function initializeApp() {
    loadCourses();
    showPage('login');

    document.getElementById('login-form').addEventListener('submit', handleLogin);
    document.getElementById('logout-btn').addEventListener('click', handleLogout);
    document.getElementById('start-exam-btn').addEventListener('click', handleStartExam);
    document.getElementById('prev-btn').addEventListener('click', previousQuestion);
    document.getElementById('next-btn').addEventListener('click', nextQuestion);
    document.getElementById('submit-exam-btn').addEventListener('click', () => submitExam(false));
    document.getElementById('retake-btn').addEventListener('click', handleRetake);
    document.getElementById('dashboard-btn').addEventListener('click', () => showPage('dashboard'));

    preventCheating();
}

async function loadCourses() {
    try {
        const response = await fetch('/get_courses');
        const data = await response.json();

        if (!response.ok) throw new Error(data.error || 'Failed to load courses');

        const courseSelect = document.getElementById('course');
        data.courses.forEach(course => {
            const option = document.createElement('option');
            option.value = course.id;
            option.text = course.name;
            courseSelect.appendChild(option);
        });
    } catch (error) {
        console.error('Error loading courses:', error);
        alert('Failed to load courses. Please refresh.');
    }
}

function showPage(pageName) {
    Object.values(pages).forEach(page => page.classList.remove('active'));
    pages[pageName].classList.add('active');

    if (pageName === 'exam') {
        document.body.classList.add('exam-page');
    } else {
        document.body.classList.remove('exam-page');
    }
}

async function handleLogin(e) {
    e.preventDefault();

    const email = document.getElementById('email').value.trim();
    const courseId = document.getElementById('course').value.trim();
    const errorElement = document.getElementById('login-error');

    try {
        if (!email || !courseId) {
            throw new Error('Please fill in all fields');
        }

        const response = await fetch('/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, course_id: parseInt(courseId) })
        });

        const data = await response.json();
        if (!response.ok) {
            throw new Error(data.error || 'Login failed');
        }

        currentUser = {
            st_id: data.st_id,
            exam_id: data.exam_id,
            student_name: data.student_name,
            course_name: data.course_name,
            course_id: data.course_id
        };

        updateDashboard();
        showPage('dashboard');
        errorElement.classList.remove('show');
    } catch (error) {
        errorElement.textContent = error.message;
        errorElement.classList.add('show');
    }
}

function updateDashboard() {
    if (!currentUser) return;
    document.getElementById('student-name').textContent = currentUser.student_name;
    document.getElementById('student-email').textContent = currentUser.st_id;
    document.getElementById('selected-course').textContent = currentUser.course_name;
}

async function handleStartExam() {
    if (!currentUser) return;
    try {
        const response = await fetch('/start_exam', { method: 'POST' });
        const data = await response.json();

        if (!response.ok) throw new Error(data.error || 'Failed to start exam');

        currentExam = {
            questions: data.questions,
            startTime: new Date(),
            duration: 30,
            answers: new Array(data.questions.length).fill(null)
        };

        userAnswers = new Array(data.questions.length).fill(null);
        currentQuestionIndex = 0;

        showPage('exam');
        initializeExam();
        startExamTimer(30);
    } catch (error) {
        alert(error.message);
    }
}

function initializeExam() {
    if (!currentExam) return;
    document.getElementById('total-questions').textContent = currentExam.questions.length;
    displayQuestion(0);
    updateProgress();
}

function displayQuestion(index) {
    if (!currentExam || index < 0 || index >= currentExam.questions.length) return;

    const question = currentExam.questions[index];
    document.getElementById('current-question-num').textContent = index + 1;
    document.getElementById('question-text').textContent = question.Question_txt;

    const optionsContainer = document.getElementById('options-container');
    optionsContainer.innerHTML = '';

    question.choices.forEach(option => {
        const optionElement = document.createElement('div');
        optionElement.className = 'option-item';
        const isSelected = userAnswers[index] === option;
        if (isSelected) optionElement.classList.add('selected');

        optionElement.innerHTML = `
            <input type="radio" name="answer" value="${option}" ${isSelected ? 'checked' : ''}>
            <span class="option-text">${option}</span>
        `;

        optionElement.addEventListener('click', () => selectAnswer(index, option, optionElement));
        optionsContainer.appendChild(optionElement);
    });

    updateNavigationButtons();
}

function selectAnswer(index, answer, element) {
    userAnswers[index] = answer;
    const siblings = element.parentElement.querySelectorAll('.option-item');
    siblings.forEach(el => el.classList.remove('selected'));
    element.classList.add('selected');
    element.querySelector('input[type="radio"]').checked = true;
    updateProgress();
}

function previousQuestion() {
    if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
        displayQuestion(currentQuestionIndex);
        updateProgress();
    }
}

function nextQuestion() {
    if (currentQuestionIndex < currentExam.questions.length - 1) {
        currentQuestionIndex++;
        displayQuestion(currentQuestionIndex);
        updateProgress();
    }
}

function updateNavigationButtons() {
    const prevBtn = document.getElementById('prev-btn');
    const nextBtn = document.getElementById('next-btn');
    const submitBtn = document.getElementById('submit-exam-btn');

    prevBtn.disabled = currentQuestionIndex === 0;
    if (currentQuestionIndex === currentExam.questions.length - 1) {
        nextBtn.style.display = 'none';
        submitBtn.style.display = 'block';
    } else {
        nextBtn.style.display = 'block';
        submitBtn.style.display = 'none';
    }
}

function updateProgress() {
    const answered = userAnswers.filter(a => a !== null).length;
    const percent = (answered / currentExam.questions.length) * 100;
    document.getElementById('progress-fill').style.width = `${percent}%`;
}

function startExamTimer(duration) {
    let timeLeft = duration * 60;
    const timer = document.getElementById('exam-timer');

    examTimer = setInterval(() => {
        const min = Math.floor(timeLeft / 60);
        const sec = timeLeft % 60;
        timer.textContent = `${String(min).padStart(2, '0')}:${String(sec).padStart(2, '0')}`;

        if (timeLeft <= 0) {
            clearInterval(examTimer);
            submitExam(true);
        }
        timeLeft--;
    }, 1000);
}

async function submitExam(autoSubmit = false) {
    if (!autoSubmit) {
        const unanswered = userAnswers.filter(a => a === null).length;
        if (unanswered > 0 && !confirm(`You have ${unanswered} unanswered questions. Submit anyway?`)) {
            return;
        }
    }

    clearInterval(examTimer);

    try {
        const answers = {};
        currentExam.questions.forEach((q, idx) => {
            answers[q.Question_ID] = userAnswers[idx] || '';
        });

        const response = await fetch('/submit_exam', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ answers })
        });

        const result = await response.json();
        if (!response.ok) throw new Error(result.error || 'Failed to submit exam');

        displayResults(result);
        showPage('results');
    } catch (error) {
        alert(error.message);
    }
}

function displayResults(result) {
    document.getElementById('score-percentage').textContent = `${result.percentage.toFixed(1)}%`;
    document.getElementById('final-score').textContent = result.correct_answers * 10;
    document.getElementById('total-marks').textContent = result.total_questions * 10;
    document.getElementById('correct-count').textContent = result.correct_answers;
    document.getElementById('incorrect-count').textContent = result.total_questions - result.correct_answers;
    document.getElementById('time-taken').textContent = `${result.time_taken || 0} minutes`;
}

function handleLogout() {
    fetch('/logout');
    currentUser = null;
    currentExam = null;
    clearInterval(examTimer);
    document.getElementById('login-form').reset();
    document.getElementById('login-error').classList.remove('show');
    showPage('login');
}

function handleRetake() {
    currentExam = null;
    clearInterval(examTimer);
    showPage('dashboard');
}

function preventCheating() {
    document.addEventListener('contextmenu', e => {
        if (document.body.classList.contains('exam-page')) e.preventDefault();
    });
    document.addEventListener('keydown', e => {
        if (document.body.classList.contains('exam-page') && (e.key === 'F12' || (e.ctrlKey && e.shiftKey) || (e.ctrlKey && e.key === 'u'))) {
            e.preventDefault();
            alert('Developer tools are disabled during the exam.');
        }
    });
    document.addEventListener('visibilitychange', () => {
        if (document.body.classList.contains('exam-page') && document.hidden) {
            alert('Warning: Do not switch tabs during the exam!');
        }
    });
    window.addEventListener('beforeunload', e => {
        if (document.body.classList.contains('exam-page')) {
            const message = 'Are you sure you want to leave? Your exam progress will be lost.';
            e.returnValue = message;
            return message;
        }
    });
}

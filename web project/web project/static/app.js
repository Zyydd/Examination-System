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

document.addEventListener('DOMContentLoaded', () => {
    initializeApp();
});

function initializeApp() {
    showPage('login');

    document.getElementById('login-form').addEventListener('submit', handleLogin);
    document.getElementById('logout-btn').addEventListener('click', handleLogout);
    document.getElementById('start-exam-btn').addEventListener('click', handleStartExam);
    document.getElementById('prev-btn').addEventListener('click', previousQuestion);
    document.getElementById('next-btn').addEventListener('click', nextQuestion);
    document.getElementById('submit-exam-btn').addEventListener('click', submitExam);
    document.getElementById('retake-btn').addEventListener('click', handleRetake);
    document.getElementById('dashboard-btn').addEventListener('click', () => showPage('dashboard'));

    preventCheating();
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
    const password = document.getElementById('password').value.trim();
    const courseName = document.getElementById('course').value.trim();
    const errorElement = document.getElementById('login-error');

    try {
        if (!email || !password || !courseName) {
            throw new Error('Please fill in all fields.');
        }

        const response = await fetch('/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email: email,
                password: password,
                course_name: courseName
            })
        });

        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.error || 'Login failed.');
        }

        currentUser = {
            st_id: data.st_id,
            exam_id: data.exam_id,
            st_email: data.email,
            student_name: data.student_name,
            course_name: data.course_name
        };

        updateDashboard();
        showPage('dashboard');
        errorElement.textContent = '';
        errorElement.classList.remove('show');

    } catch (error) {
        errorElement.textContent = error.message;
        errorElement.classList.add('show');
    }
}

function updateDashboard() {
    if (!currentUser) return;

    document.getElementById('student-name').textContent = currentUser.student_name;
    document.getElementById('student-email').textContent = currentUser.st_email;
    document.getElementById('selected-course').textContent = currentUser.course_name;
}

async function handleStartExam() {
    try {
        const response = await fetch('/start_exam', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' }
        });

        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.error || 'Failed to start the exam.');
        }

        currentExam = {
            questions: data.questions,
            startTime: new Date(),
            duration: 15,
            answers: new Array(data.questions.length).fill(null)
        };

        currentQuestionIndex = 0;
        userAnswers = new Array(data.questions.length).fill(null);

        showPage('exam');
        initializeExam();
        startExamTimer(currentExam.duration);

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

    question.choices.forEach(choice => {
        const optionDiv = document.createElement('div');
        optionDiv.classList.add('option-item');

        const input = document.createElement('input');
        input.type = 'radio';
        input.name = 'answer';
        input.value = choice;
        if (userAnswers[index] === choice) input.checked = true;

        const label = document.createElement('span');
        label.textContent = choice;

        optionDiv.appendChild(input);
        optionDiv.appendChild(label);

        optionDiv.addEventListener('click', () => {
            userAnswers[index] = choice;
            updateProgress();
            displayQuestion(index);
        });

        optionsContainer.appendChild(optionDiv);
    });

    updateNavigationButtons();
}

function updateNavigationButtons() {
    document.getElementById('prev-btn').disabled = currentQuestionIndex === 0;
    if (currentQuestionIndex === currentExam.questions.length - 1) {
        document.getElementById('next-btn').style.display = 'none';
        document.getElementById('submit-exam-btn').style.display = 'block';
    } else {
        document.getElementById('next-btn').style.display = 'block';
        document.getElementById('submit-exam-btn').style.display = 'none';
    }
}

function previousQuestion() {
    if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
        displayQuestion(currentQuestionIndex);
    }
}

function nextQuestion() {
    if (currentQuestionIndex < currentExam.questions.length - 1) {
        currentQuestionIndex++;
        displayQuestion(currentQuestionIndex);
    }
}

function updateProgress() {
    const answered = userAnswers.filter(ans => ans !== null).length;
    const percentage = (answered / currentExam.questions.length) * 100;
    document.getElementById('progress-fill').style.width = `${percentage}%`;
}

function startExamTimer(duration) {
    let timeLeft = duration * 60;
    const timerElement = document.getElementById('exam-timer');

    examTimer = setInterval(() => {
        const minutes = Math.floor(timeLeft / 60);
        const seconds = timeLeft % 60;
        timerElement.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

        if (timeLeft <= 0) {
            clearInterval(examTimer);
            submitExam(true);
        }

        timeLeft--;
    }, 1000);
}

async function submitExam(autoSubmit = false) {
    if (!autoSubmit) {
        const unanswered = userAnswers.filter(ans => ans === null).length;
        if (unanswered > 0 && !confirm(`You have ${unanswered} unanswered questions. Submit anyway?`)) {
            return;
        }
    }

    clearInterval(examTimer);

    const answers = {};
    currentExam.questions.forEach((q, idx) => {
        answers[q.Question_ID] = userAnswers[idx] || '';
    });

    try {
        const response = await fetch('/submit_exam', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ answers })
        });

        const result = await response.json();

        if (!response.ok) {
            throw new Error(result.error || 'Failed to submit the exam.');
        }

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
    currentUser = null;
    currentExam = null;
    clearInterval(examTimer);
    document.getElementById('login-form').reset();
    document.getElementById('login-error').textContent = '';
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
        if (document.body.classList.contains('exam-page')) {
            if (e.key === 'F12' || (e.ctrlKey && e.shiftKey && ['I', 'C', 'J'].includes(e.key)) || (e.ctrlKey && e.key === 'U')) {
                e.preventDefault();
            }
        }
    });

    document.addEventListener('visibilitychange', () => {
        if (document.body.classList.contains('exam-page') && document.hidden) {
            alert('Warning: Switching tabs during the exam is not allowed.');
        }
    });

    window.addEventListener('beforeunload', e => {
        if (document.body.classList.contains('exam-page')) {
            e.preventDefault();
            e.returnValue = 'Are you sure you want to leave? Your exam progress will be lost.';
        }
    });
}

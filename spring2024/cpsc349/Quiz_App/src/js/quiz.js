document.addEventListener('DOMContentLoaded', function() {
    // Get the Selected Quiz Based off the Option Selected (Query String)
    // i.e. I've already taken back-end - Kyle W.
    const parameters = new URLSearchParams(window.location.search);
    const quiz = parameters.get('quiz');

    // Load Quiz Data from the corespondding JSON File
    const quizDataPath = `../data/${quiz}.json`

    let currentIndex = 0;
    let score = 0;
    let timeForQuestion = 15;
    let timer;
    var quizData;

    fetch(quizDataPath)
        .then(response => response.json())
        .then(data => {
            quizData = data;
            displayQuiz();
        })
        .catch(e => console.error("Failed to Load Quiz Data: ", e));
        setActiveNavLink();


    // Have the Submit Button to Listen for Selected Answers
    document.getElementById('submit-button').addEventListener('click', submitAnswer);

    function setActiveNavLink() {
        // Set the Nav Link for the active quiz
        const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
        navLinks.forEach(link => {
        link.classList.remove('active');
        link.removeAttribute('aria-current');

        if (link.getAttribute('data-quiz') == quiz) {
        link.classList.add('active');
        link.setAttribute('aria-current', 'page');
        }
    });
    }

    function displayQuiz() {
        
        clearInterval(timer);

        // If the quiz is over
        if(currentIndex >= quizData.length) {
            endQuiz();
            return;
        }

        const questionObject = quizData[currentIndex];
        document.getElementById('question').textContent = questionObject.question;
        document.getElementById('question-image').src = questionObject.image;

        const questionOptions = document.getElementById('question-choices');
        questionOptions.innerHTML = '';

        questionObject.options.forEach((choices) => {
            const column = document.createElement('div');
            column.classList.add('col-6');
            // Create the Buttons for the Answer Choices
            const optionButtons = document.createElement('button');
            optionButtons.classList.add('btn', 'btn-primary', 'w-100');
            optionButtons.type = "button"
            optionButtons.textContent = choices;
            optionButtons.setAttribute('data-answer-choice', choices);
            // Updates the currently selected button
            optionButtons.onclick = function() { selectedAnswer(optionButtons)};
            column.appendChild(optionButtons);
            questionOptions.appendChild(column)
        });

        // Update the Progress Bar and Reset(Start the Timer) for the Questions
        updateQuizProgress();
        startTimer();
    }

    // If the Answer is Submitted
    function selectedAnswer(optionButtons) {
        // Make Sure all previous selctions are removed
        document.querySelectorAll("#question-choices .btn").forEach(btn => {
            btn.classList.remove('active');
        });

        // Update the New button as being selected
        optionButtons.classList.add('active')
    }

    //Submit Answer
    function submitAnswer() {
        const selectedOption = document.querySelector("#question-choices .btn.active").textContent
        if(selectedOption === quizData[currentIndex].answer) {
            score++;
        }
        currentIndex++;
        displayQuiz();

    }

    function startTimer() {
        // Update the Timeer as the Seconds Count Down
        let timeLeft = timeForQuestion
        document.getElementById('timer').textContent = `Time Left: ${timeLeft}`;
        timer = setInterval(() => {
            timeLeft--;
            document.getElementById('timer').textContent = `Time Left: ${timeLeft}`;
            if (timeLeft === 0) endQuiz();  
        }, 1500);
    }

    function updateQuizProgress() {
        // Get the current Progress of the Quiz
        const progressbarProgress = (currentIndex / quizData.length) * 100;
        document.getElementById("progress-bar").style.width = `${progressbarProgress}%`;
    }

    function endQuiz() {
        updateQuizProgress();
        clearInterval(timer);
        finalScore = Math.round((score/quizData.length) * 100)
        //alert(`Quiz finished! You scored: ${finalScore} %`);
        const scoreAlert = document.createElement('div');
        if (finalScore > 50) {
            scoreAlert.classList.add('alert', 'alert-success') 
            scoreAlert.textContent = `Congratulations, You scored ${finalScore} %`                       
        } else {
            scoreAlert.classList.add('alert', 'alert-danger')
            scoreAlert.textContent = `Too Bad Better Luck Next Time, You scored ${finalScore} %`                                             
        }
        
        scoreAlert.setAttribute('role','alert')
        alertBar = document.getElementById('quiz-container')
        alertBar.appendChild(scoreAlert)
        const backToHomePage = document.getElementById("home-btn");
        const homeButton = document.createElement('button')
        homeButton.classList.add('btn', 'btn-primary', 'w-25');
        homeButton.type = "button"
        homeButton.innerHTML = "Go Back to Home"
        // Buttons do not inherently have links <a> so...
        homeButton.addEventListener('click', function() {
            window.location.href = './index.html';
        });
        backToHomePage.appendChild(homeButton);

    }

});
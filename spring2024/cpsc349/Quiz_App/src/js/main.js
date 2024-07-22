import '../scss/styles.scss'

// Carousel Images
import itachiImage from '../images/quiz1/naruto.jpeg'
import ghoulImage from '../images/quiz1/ghoul.jpeg'
import saoImage from '../images/quiz1/sao.png'

// Card Images
import soloImage from '../images/quiz1/solo.jpeg'
import comsci from '../images/comsci.jpeg'
import general from '../images/quiz3.png'

// Bootstrap Components
import { Carousel } from 'bootstrap';

// Custom Carousel for Homepage
const imageCarousel = [
    { src: itachiImage, alt: "Itachi"},
    { src: comsci, alt: "Computer Science"},
    { src: general, alt: "gerneral quiz image"}
]

// Card Images for Homepage
const imageCard = [
    {src: soloImage, alt: "Solo Leveling", title: "Anime Quiz", text: "Can you guess what anime are these or which characters they are? Come and Find Out"},
    {src: comsci, alt: "Quiz 2 Image", title: "Programming Quiz", text: "Fun Quiz about basic info in computer science world."},
    {src: general, alt: "Quiz 3 Image", title: "General Info", text: "A general quiz about random stuff around the globe."}
    
]

const carouselInner = document.querySelector('.carousel-inner')

imageCarousel.forEach((image, index) => {
    const carouselItem = document.createElement('div');
    carouselItem.classList.add('carousel-item');
    if (index === 0) carouselItem.classList.add('active');
    const carouselImg = document.createElement('img');
    carouselImg.src = image.src;
    carouselImg.alt = image.alt;
    carouselImg.classList.add('d-block', 'w-100');

    carouselInner.appendChild(carouselItem);
    carouselItem.appendChild(carouselImg);
});


const cardImages = document.querySelector('#quiz-cards')

imageCard.forEach((image, index) => {
    // Add a Column for Each Card
    const column = document.createElement('div');
    column.classList.add('col');

    //To the Column add the Cards
    const card = document.createElement('div');
    card.classList.add('card');
    //Append as Child to the Column
    column.appendChild(card);

    // Add Image to Each Card
    const cardImg = document.createElement('img');
    cardImg.src = image.src;
    cardImg.alt = image.alt;
    cardImg.classList.add('card-img-top');
    //Append as Child to the Card
    card.appendChild(cardImg);

    const cardBody = document.createElement('div');
    cardBody.classList.add('card-body');
    //Append as Child to the Card
    card.appendChild(cardBody);

    const cardTitle = document.createElement('h5');
    cardTitle.classList.add('card-title');
    cardTitle.textContent = image.title;
    cardBody.appendChild(cardTitle);

    const cardInfo = document.createElement('p');
    cardInfo.classList.add('card-text');
    //Append Info to the CardBody
    cardInfo.textContent = image.text;
    cardBody.appendChild(cardInfo);

    const cardLink = document.createElement('a')
    cardLink.classList.add('stretched-link')
    cardLink.id = `quiz${index+1}`
    cardLink.href = `quiz.html?quiz=quiz${index+1}`
    cardBody.append(cardLink)
    
    //Append the Column to the Row
    cardImages.appendChild(column);

});

// Initialize the carousel
const carousel = new Carousel(document.querySelector("#carouselQuiz"));

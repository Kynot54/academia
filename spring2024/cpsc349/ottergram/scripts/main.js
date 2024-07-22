var DETAIL_IMAGE_SELECTOR = '[data-image-role="target"]';
var DETAIL_TITLE_SELECTOR = '[data-image-role="title"]';
var DETAIL_FRAME_SELECTOR = '[data-image-role="frame"]';
var THUMBNAIL_LINK_SELECTOR = '[data-image-role="trigger"]';
var PREV_ARROW_SELECTOR = '[data-image-button="prev-arrow"]';
var NEXT_ARROW_SELECTOR = '[data-image-button="next-arrow"]';
var HIDDEN_DETAIL_CLASS = 'hidden-detail';
var TINY_EFFECT_CLASS = 'is-tiny';
var ESC_KEY = 27;

function setDetails(imageUrl, titleText) {
  'use strict';

  let detailImage = document.querySelector(DETAIL_IMAGE_SELECTOR);
  detailImage.setAttribute('src', imageUrl);

  let detailTitle = document.querySelector(DETAIL_TITLE_SELECTOR);
  detailTitle.textContent = titleText;
}

function imageFromThumb(thumbnail) {
  'use strict';
  return thumbnail.getAttribute('data-image-url');
}

function titleFromThumb(thumbnail) {
  'use strict';
  return thumbnail.getAttribute('data-image-title')
}

function setDetailsFromThumb(thumbnail) {
  'use strict';
  setDetails(imageFromThumb(thumbnail), titleFromThumb(thumbnail));
}

function addThumbClickHandler(thumb) {
  thumb.addEventListener('click', function (event) {
    event.preventDefault();
    setDetailsFromThumb(thumb);
    showDetails();
  });
}

function setDetailsFromArrow(direction) {
    'use strict';
    let thumbnails = getThumbnailsArray();
    let images = getImages();

    var currentIndex = images.indexOf(document.getElementById("detail-image")).src;
    console.log(currentIndex);
    currentIndex = direction === 'next' ? currentIndex + 1 : currentIndex - 1;
    console.log(currentIndex);

    let nextArrow = document.querySelector(NEXT_ARROW_SELECTOR);
    let prevArrow = document.querySelector(PREV_ARROW_SELECTOR);
    
    if (currentIndex >= thumbnails.length - 1) {nextArrow.classList.add(HIDDEN_DETAIL_CLASS);}
    else if (currentIndex < 0) {prevArrow.classList.add(HIDDEN_DETAIL_CLASS);}
    else {
        if (currentIndex < thumbnails.length - 1) {nextArrow.classList.remove(HIDDEN_DETAIL_CLASS);}
        else if (currentIndex >= 1) {prevArrow.classList.remove(HIDDEN_DETAIL_CLASS);}
    }
    thumbnails[currentIndex].click();
}

function getThumbnailsArray() {
  'use strict';
  let thumbnails = document.querySelectorAll(THUMBNAIL_LINK_SELECTOR);
  const thumbnailArray = [].slice.call(thumbnails);
  return thumbnailArray;
}

function getImages() {
    'use strict';
    let images = getThumbnailsArray();
    for (let i = 0; i < images.length; i++) {images[i] = images[i].href;}
    return images;
}

function hideDetails() {
  'use strict';
  document.body.classList.add(HIDDEN_DETAIL_CLASS);
}

function showDetails() {
    'use strict';
    var frame = document.querySelector(DETAIL_FRAME_SELECTOR);
    document.body.classList.remove(HIDDEN_DETAIL_CLASS);
    frame.classList.add(TINY_EFFECT_CLASS);
    setTimeout(function () {
        frame.classList.remove(TINY_EFFECT_CLASS);
    }, 50);
}

function addKeyPressHandler() {
    'use strict';
    document.body.addEventListener('keyup', function(event) {
    event.preventDefault();
    console.log(event.keyCode);
    if (event.keyCode === ESC_KEY) {
      hideDetails();
    }
  });
}

function addArrowClickHandler(selector, direction) {
    'use strict';
    let arrow = document.querySelector(selector);
    arrow.addEventListener('click', function(event) {
        event.preventDefault();
        setDetailsFromArrow(direction);
  });
}

function initializeEvents() {
  'use strict';
  let thumbnails = getThumbnailsArray();
  thumbnails.forEach(addThumbClickHandler);
  addKeyPressHandler();
  addArrowClickHandler(PREV_ARROW_SELECTOR, 'prev');
  addArrowClickHandler(NEXT_ARROW_SELECTOR, 'next');
}

initializeEvents();

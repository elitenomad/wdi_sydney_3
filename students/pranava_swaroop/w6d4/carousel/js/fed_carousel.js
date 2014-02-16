var carousel = document.getElementById('carousel');
var next = document.getElementById('next');
var previous = document.getElementById('previous');

var imgWidth = 612;
var stepLength = 12;
var movedFor = 0;
var move = "";

carousel.style.marginLeft = 0;
var actualImage = 1;
// Slides the images to the left or goes back to the first image if it has reached the end



function toLeft() {
  if (actualImage < 3 ) {
    movedFor = 0;
    move = window.setInterval(stepLeft, 0);
    actualImage = actualImage + 1;
  } else { 
    movedFor = 0;
    move = window.setInterval(fastBackToFirst,0);
    actualImage = 1;
  }
}

function fastBackToFirst() {
  if (movedFor >= 2 * imgWidth ) {
    window.clearInterval(move);
  } else {
    carousel.style.marginLeft = parseInt(carousel.style.marginLeft) + (2 * stepLength) + "px";
    movedFor = movedFor + 2 * stepLength;
  }
}

function stepLeft() {
  if (movedFor >= imgWidth ) {
    window.clearInterval(move);
  }
  else {
    carousel.style.marginLeft = parseInt(carousel.style.marginLeft) - stepLength + "px";
    movedFor = movedFor + stepLength;
  }
}


// Slides the images to the right or goes back to the last image if it has reached the end
// previous
function toRight(){
  if (actualImage > 1 ) {
    movedFor = 0;
    move = window.setInterval(stepRight, 0);
    actualImage = actualImage - 1;
  } else { 
    move = window.setInterval(fastMoveToLast,0)
    actualImage = 3;
  }
}

function stepRight() {
  if (movedFor >= imgWidth ) {
    window.clearInterval(move);
  } else {
    carousel.style.marginLeft = parseInt(carousel.style.marginLeft) + stepLength + "px";
    movedFor = movedFor + stepLength;
  }
}

function fastMoveToLast() {
  if (movedFor >= 2 * imgWidth ) {
    window.clearInterval(move);
  } else {
    carousel.style.marginLeft = parseInt(carousel.style.marginLeft) - (2 * stepLength) + "px";
    movedFor = movedFor + 2 * stepLength;
  }
}

function putOpacityNext() {
  next.style.opacity = "1";
}

function cutOpacityNext() {
  next.style.opacity = "0.5";
}

function putOpacityPrevious() {
  previous.style.opacity = "1";
}

function cutOpacityPrevious() {
  previous.style.opacity = "0.5";
}


//Hook up the next and previous buttons to call the toLeft and toRight functions

previous.addEventListener("click",toRight);
next.addEventListener("click",toLeft);

previous.addEventListener("mouseover",putOpacityPrevious);
previous.addEventListener("mouseout",cutOpacityPrevious);

next.addEventListener("mouseover",putOpacityNext);
next.addEventListener("mouseout",cutOpacityNext);
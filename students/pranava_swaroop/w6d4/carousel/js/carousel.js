var carousel = document.getElementById('carousel');
var next = document.getElementById('next');
var previous = document.getElementById('previous');
var images =  ['images/ankor-wat.jpg','images/austin-fireworks.jpg','images/ibiza.jpg','images/taj-mahal.jpg'];
var image_number = 0;
var image_length = images.length-1; 
carousel.style.marginLeft = 0;
 
// Slides the images to the left or goes back to the first image if it has reached the end
function toLeft(){
	

}
 
 
// Slides the images to the right or goes back to the last image if it has reached the end
//function toRight(){
function toRight(){

}

function changeNextOpacity(){
	next.style.opacity =1;

}

function revertNextOpacity(){
	next.style.opacity = 0.5;

}
function changePreviousOpacity(){
	previous.style.opacity = 1;

}

function revertPreviousOpacity(){
	previous.style.opacity = 0.5;

}

function onLoad(){
	num=-1;
	image_number = image_number+num;

	if(image_number > image_length ){
		image_number=0;
	}

	if(image_number < 0 ){
		image_number= image_length;
	}

	document.fireworks.src = images[image_number];
}


window.setInterval(onLoad,3000);

next.addEventListener("mouseover",changeNextOpacity);
previous.addEventListener("mouseover",changePreviousOpacity)
next.addEventListener("mouseout",revertNextOpacity);
previous.addEventListener("mouseout",revertPreviousOpacity)
 
// Hook up the next and previous buttons to call the toLeft and toRight functions

next.addEventListener("click", function(){
	num=-1;
	image_number = image_number+num;

	if(image_number > image_length ){
		image_number=0;
	}

	if(image_number < 0 ){
		image_number= image_length;
	}

	document.fireworks.src = images[image_number];
});
previous.addEventListener("click", function(){
	num=1;
	image_number = image_number+num;

	if(image_number > image_length ){
		image_number=0;
	}

	if(image_number < 0 ){
		image_number= image_length;
	}

	document.fireworks.src = images[image_number];
});
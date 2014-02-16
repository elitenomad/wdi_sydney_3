var carousel = document.getElementById('carousel');
var next = document.getElementById('next');
var previous = document.getElementById('previous');
 

var images = document.getElementsByTagName("img");
carousel.style.marginLeft = 0;
 
// Slides the images to the left or goes back to the first image if it has reached the end
function toLeft(){
}
 
 
// Slides the images to the right or goes back to the last image if it has reached the end
function toRight(event){
	function imageShift() {
		var currentLeft = parseInt(carousel.style.marginLeft);
		carousel.style.marginLeft = (currentLeft + 10) + 'px';
    	if (currentLeft > (window.innerWidth-carousel.width)) { // reset if reach right side window
    		carousel.style.marginLeft = '0px';
    	}
	}
	imgTimer = window.setInterval(imageShift, 1);
}

function onLoad(){
	// for(var i=1;i < images.length;i=i+1){
	// 	images[i].style.display="none";
	// }
}

//window.addEventListener("load",onLoad);
 
//Hook up the next and previous buttons to call the toLeft and toRight functions
next.addEventListener("click",toRight);
previous.addEventListener("click",toLeft);
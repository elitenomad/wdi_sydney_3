$(document).ready(function(){
	clickedVals = {};
	completedVals ={};
	count = 0;
	var timer = null;

	$("#game").hide();

	$("#small").on("click",function(){
		$("#game").show();

		/*
			Reset span ID's . //Remove class works on collection
		*/
		$('#game > div').each(function(i){
			$(this).removeClass("found");
		});
		

		/*
			Reset statuses
		*/
		$('#status').html("").removeClass('won');
		$('#game > div').addClass('clickable');
		/*
			Assign ID's to cards
		*/
		assignCards();
		clickedVals = {};
		completedVals ={};
	});

	

	$('#game').on('click', '.clickable',function(){
		if(timer === null){
			timer = window.setInterval(displayCounter,1000);
		}
		console.log("iam coming")
		$(this).find('span').toggle();

		divClicked = this.id;
		clickedVals[divClicked] = $(this).find('span').html();
		console.log(clickedVals);

		if(_.size(clickedVals) <= 1 ){
			//User has to pick two cards
			return; 
		}


		if(_.size(clickedVals) > 1){

			keys = _.keys(clickedVals);
			if(keys[0] === keys[1]){
				return;
			}else{
				if(clickedVals[keys[0]] === clickedVals[keys[1]]){
					//match
					$.each( clickedVals, function( key, value ) {
					  $('#'+key).addClass('found');
					  $('#'+key).removeClass('clickable');
					});

					$.extend(completedVals, clickedVals );
					clickedVals = {};

					if(_.size(completedVals) === 10){
						$('#status').addClass('won').html('Game completed in '+ count +' seconds. click \
								small to play the game again');
						$("#game").hide();
						clearCounter();
					}
				}else{
					/*
						match and hide the span keys
					*/
					$.each( clickedVals, function( key, value ) {
					  $('#'+key).find('span').hide();
					});
					clickedVals = {};
				}
			}
			
		}

		console.log(clickedVals); 
		
	});


	function assignCards(){
		cardName = ['A','B','C','D','E','F','G','H','I','J','K',
				 'L','M','N','O','P','Q','R','S','T','U','V',
				 'W','X','Y','Z'];
		randomVals = _.sample(cardName,5);
		randomVals = _.shuffle($.merge(randomVals,randomVals));

		/*
			Loop through the div's under game div
			and assign a variable and By default 
			span will be hidden
		*/
		$('#game > div').each(function(i){
			$(this).find('span').html(randomVals[i]);
			hideElement($(this));
		});

	}
	
	function hideElement(el){
		el.find('span').hide();
	}

	function toggleElement(el){
		el.toggleClass('hover');
	}

	function displayCounter(){
		count = count+1;
		$('#timer').html(count);
	}

	function clearCounter(){
		window.clearInterval(timer);
		$('#timer').html('');
	}

	/*
		Hover functionality
	*/
	$('div.column').on('mouseover',function(){
		toggleElement($(this));
	});

	$('div.column').on('mouseout',function(){
		toggleElement($(this));
	});

});
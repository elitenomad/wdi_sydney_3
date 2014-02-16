var word = {
  secretWord: "",
  wordList: ['ruby', 'rails', 'javascript', 'array', 'hash', 'underscore', 'sinatra', 'model', 'controller', 
              'view', 'devise', 'authentication', 'capybara', 'jasmine', 
              'cache', 'sublime', 'terminal', 'system', 'twitter', 'facebook', 
              'function', 'google', 'amazon', 'development', 'data', 'design', 
              'inheritance', 'prototype', 'gist', 'github', 'agile', 'fizzbuzz', 
              'route', 'gem', 'deployment', 'database'],

  // Selects a random word from the word list sets the secret word
  setSecretWord: function(){
    word.secretWord = word["wordList"][(_.random(0, _.size(word["wordList"])))];
  },

  // Takes an array of letters as input and returns an array of two items:
  // 1) A string with the parts of the secret word that have been guessed correctly and underscore for the parts that haven't
  // 2) An array of all the guessed letters that were not in the secret word
  checkLetters: function(guessedLetters){
      guess = document.getElementById("guessedLetters");
      guess.innerHTML = "[ "+ _.flatten(player.oldGuessedLetters) + " ] ;" + " [ "+ guessedLetters + " ]";

  }
};

var player = {
  MAX_GUESSES: 8,
  guessedLetters: [],
  oldGuessedLetters:[],

  // Takes a new letter as input and updates the game
  makeGuess: function(letter){

    key = String.fromCharCode(letter.charCode);
    var secretWordLength = word.secretWord.length;
    var present = false;
    for(var i=0 ; i< secretWordLength;i=i+1){
      if(key === word.secretWord[i]){
        present=true;
        break;
      }
    } 
    if(present){
      player.oldGuessedLetters.push(player.guessedLetters);
      player.guessedLetters=[];
      document.getElementById("guessesLeft").innerHTML = 8;
      for(var i=0; i < secretWordLength ; i++){
        if(key === word.secretWord[i]){
           game.dash = game.dash.replaceAt(i, key);
        }
      }
      wordStr.innerHTML = game.dash;
      if(game.dash.indexOf("_") < 0 ){
        player.checkWin();
      }
    }else{
      player["guessedLetters"].push(key);
      document.getElementById("guessesLeft").innerHTML = player["MAX_GUESSES"] - (player["guessedLetters"].length);
      word.checkLetters(player["guessedLetters"]);
    }

    // check the letter is present in the secredword string
    // if its not present increase the guess value and push it to guessedLetters
    // if its present update the positions of that letter in the secret word on the page

    guessLength = _.size(player["guessedLetters"]);
    if(guessLength >= 8){
      stringEntered = document.getElementById("letterField").value;
      player.checkLose(stringEntered);
    }
    
  },

  // Check if the player has won and end the game if so
  checkWin: function(wordString){
    alert("Hurrah!!! You won the game");
    var conf = confirm("Do you want to play another game ? ");
    if(conf){
      game.resetGame();
    }else{
      window.close();
    }


  },

  // Check if the player has lost and end the game if so
  checkLose: function(wrongLetters){
    alert("You have lost the game, you guessed "+ wrongLetters +" and the correct solution is "+word["secretWord"]);
    /*
      Please request for confirm message to reset and play again or close the browser
    */

    var conf = confirm("Do you want to play another game ? ");
    if(conf){
      game.resetGame();
    }else{
      window.close();
    }
  }
  
};

var game = {
  // Resets the game
  resetGame: function(){
    word["setSecretWord"]();
    wordStr = document.getElementById("wordString");
    secretWord = word["secretWord"];
    game.dash = "";
    for(var i=0; i < secretWord.length; i++){
      game.dash +="_";
    }
    wordStr.innerHTML = game.dash;

    //Reset Fields
    document.getElementById("guessedLetters").innerHTML="";
    document.getElementById("letterField").value="";
    player.guessedLetters=[];
    player.oldGuessedLetters=[];
  },

  // Reveals the answer to the secret word and ends the game
  giveUp: function(){
    alert("Better Luck next time and the word is " + word["secretWord"]);
    game.resetGame();
  },

  // Update the display with the parts of the secret word guessed, the letters guessed, and the guesses remaining
  updateDisplay: function(secretWordWithBlanks, guessedLetters, guessesLeft){

  },
  dash: ""
};

String.prototype.replaceAt=function(index, char) {
    var a = this.split("");
    a[index] = char;
    return a.join("");
}

window.onload = function(){
  // Start a new game
  game["resetGame"]();
  // Add event listener to the letter input field to grab letters that are guessed
  document.getElementById("letterField").addEventListener("keypress",player["makeGuess"]);
  // Add event listener to the reset button to reset the game when clicked
  document.getElementById("resetButton").addEventListener("click",game["resetGame"]);
  // Add event listener to the give up button to give up when clicked
  document.getElementById("giveUpButton").addEventListener("click",game["giveUp"]);
};
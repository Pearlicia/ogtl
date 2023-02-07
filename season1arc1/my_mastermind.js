const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const possibleColors = ['0', '1', '2', '3', '4', '5', '6', '7', '8'];
let attempts = 10;
let secretCode;

const generateSecretCode = () => {
  let code = '';
  while (code.length < 4) {
    let color = possibleColors[Math.floor(Math.random() * 9)];
    if (!code.includes(color)) {
      code += color;
    }
  }
  return code;
};

const checkGuess = (guess) => {
  let wellPlaced = 0;
  let misPlaced = 0;
  for (let i = 0; i < 4; i++) {
    if (guess[i] === secretCode[i]) {
      wellPlaced++;
    } else if (secretCode.includes(guess[i])) {
      misPlaced++;
    }
  }
  return [wellPlaced, misPlaced];
};

console.log('Will you find the secret code?');
console.log('Please enter a valid guess');

rl.on('line', (input) => {
  if (!secretCode) {
    secretCode = generateSecretCode();
  }
  if (input === secretCode) {
    console.log('Congratz! You did it!');
    rl.close();
  } else if (input.length !== 4) {
    console.log('Wrong input!');
  } else {
    const [wellPlaced, misPlaced] = checkGuess(input);
    console.log(`---\nRound ${10 - attempts + 1}`);
    console.log(`>${input}`);
    console.log(`Well placed pieces: ${wellPlaced}`);
    console.log(`Misplaced pieces: ${misPlaced}`);
    attempts--;
    if (attempts === 0) {
      console.log('You lost!');
      rl.close();
    }
  }
});

rl.on('close', () => {
  process.exit(0);
});


// This code uses the readline module to handle user input and the process.stdin stream for reading user input. 
// The generateSecretCode function generates a random secret code and the checkGuess function checks the player's guess 
// against the secret code and returns the number of well placed and misplaced pieces. The code also handles the end of file 
// (Ctrl + d) by closing the readline interface and exiting the process.
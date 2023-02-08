const SAN_SIZE = 4;

function myGetDigit(str) {
  const strLength = str.length;
  for (let i = 0; i < strLength; i++) {
    if (!(str[i] >= '0' && str[i] <= '9')) {
      return 1;
    }
  }
  return 0;
}

function getRndNums() {
  const coding = [];
  const genNewNum = {};

  for (let i = 0; i < SAN_SIZE; i++) {
    let myIntNum = Math.floor(Math.random() * 10);
    while (genNewNum[myIntNum]) {
      myIntNum = Math.floor(Math.random() * 10);
    }
    coding[i] = myIntNum;
    genNewNum[myIntNum] = true;
  }
  return coding;
}

function strConvertInt(param1, param2) {
  let i;
  const genNewNumStr = [0, 0];
  for (i = 0; param2[i] !== '\0'; i++) {
    genNewNumStr[0] = param2[i];
    param1[i] = parseInt(genNewNumStr.join(''));
  }
}

function main() {
  let hidingCode = [];
  let genANewNum = 10;
  let rounds = 0;
  const predit = [];
  const args = process.argv.slice(2);

  if (args.length > 2) {
    if (myGetDigit(args[2]) !== 0 || args[2].length !== 4) {
      console.log(`Wrong input ${args[2]} passed`);
      hidingCode = getRndNums();
    } else {
      if (args[1] === '-c') {
        strConvertInt(hidingCode, args[2]);
      } else if (args[1] === '-t') {
        genANewNum = parseInt(args[2]);
        if (genANewNum > 10) {
          genANewNum = 10;
        }
      }
    }
  } else {
    hidingCode = getRndNums();
  }

  console.log('Will you find the secret code?');
  console.log('Please enter a valid guess');

  const readline = require('readline');
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  function guess() {
    console.log(`\nRound ${rounds}`);
    rounds++;

    rl.question('Guess: ', (input) => {
      let wellPlaced = 0;
      let misplaced = 0;
      if (input.length <= 4) {
        genANewNum--;
        return;
      }
      const myIntNum = parseInt(input);
      if (myIntNum === 0) {
        console.log('Wrong input passed.');
        genANewNum--;
        guess();
        return;
      } else {
        strConvertInt(predit, input);

function drawLine(length, symbol) {
    let line = '';
    for (let i = 0; i < length; i++) {
      line += symbol;
    }
    return line;
  }
  
  function drawSquare(x, y) {
    let square = '';
    for (let i = 0; i < y; i++) {
      if (i === 0 || i === y - 1) {
        square += 'o' + drawLine(x - 2, '-') + 'o\n';
      } else {
        square += '|' + drawLine(x - 2, ' ') + '|\n';
      }
    }
    return square;
  }
  
  let x = parseInt(process.argv[2]);
  let y = parseInt(process.argv[3]);
  console.log(drawSquare(x, y));
  console.log(drawSquare(5, 3));
  console.log(drawSquare(5, 1));
  console.log(drawSquare(1, 1));
  console.log(drawSquare(1, 5));
  console.log(drawSquare(4, 4));
  console.log(drawSquare(20, 20));
  console.log(drawSquare(2));
  console.log(drawSquare(5, 3));
  console.log(drawSquare());
  console.log(drawSquare("", ""));

  
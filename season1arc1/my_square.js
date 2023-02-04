// function mySquare(x, y) {
//     if (x === 1) {
//       for (let i = 0; i < y; i++) {
//         if (i === 0 || i === y - 1) {
//           console.log("o");
//         } else {
//           console.log("|");
//         }
//       }
//     } else if (y === 1) {
//       let row = "o";
//       for (let i = 0; i < x - 2; i++) {
//         row += "-";
//       }
//       console.log(row + "o");
//     } else {
//       let topAndBottom = "o";
//       for (let i = 0; i < x - 2; i++) {
//         topAndBottom += "-";
//       }
//       topAndBottom += "o";
//       console.log(topAndBottom);
//       for (let i = 0; i < y - 2; i++) {
//         let middleRow = "|";
//         for (let j = 0; j < x - 2; j++) {
//           middleRow += " ";
//         }
//         middleRow += "|";
//         console.log(middleRow);
//       }
//       console.log(topAndBottom);
//     }
//   }

function my_square(x, y) {
    let topBottom = "o";
    let middle = "|";
    for (let i = 0; i < x - 2; i++) {
      topBottom += "-";
    }
    topBottom += "o";
  
    for (let i = 0; i < x - 2; i++) {
      middle += " ";
    }
    middle += "|";
  
    console.log(topBottom);
    for (let i = 0; i < y - 2; i++) {
      console.log(middle);
    }
    console.log(topBottom);
  }
  
  
my_square(5, 3);
my_square(5, 1);
my_square(1, 1);
my_square(1, 5);
my_square(4, 4);
my_square(20, 20);
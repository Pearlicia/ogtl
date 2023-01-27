const input = [
    {"string": "John", "integer": 7},
    {"string": "Margot", "integer": 8},
    {"string": "Jules", "integer": 4},
    {"string": "Marco", "integer": 19}
]

// function my_average_mark(arrobj) {
//     const { length } = arrobj;
//     return arrobj.reduce((str, int) => {
//        return str + (int.integer/length);
//     }, 0);
//  };
//  console.log(my_average_mark(input));
console.log(Object.entries(input)[2].values());

// const myArray = [{x:100}, {x:200}, {x:300}];
// function my_average_mark(arrobj) {
//     var values = arrobj.map(function(o) { return o.; });
//     const sum = arrobj.map(element => element.x).reduce((a, b) => a + b, 0);
//     console.log(sum); // 600 = 0 + 100 + 200 + 300
//     const average = sum / myArray.length;
//     console.log(average); // 2
// }

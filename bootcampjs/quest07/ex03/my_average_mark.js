// Assignment:
// You have a test for a class and we want to know the average results for the class. Write a function that takes an array of hash with all of the grades/marks for a given test and returns an average grade for the entire class.
// Input are in JSON (be careful ruby users, "string": is not a symbol)
// Example 00: (In Javascript)
// John, Margot, Jules, and Marco are in a class together.

// Input: [
//         {"string": "John", "integer": 7},
//         {"string": "Margot", "integer": 8},
//         {"string": "Jules", "integer": 4},
//         {"string": "Marco", "integer": 19}
//        ]

// Output: 9.5
// Example 01

// Input: [
//         {"string": "Quentin", "integer": 1},
//         {"string": "Fred", "integer": 1},
//         {"string": "Julia", "integer": 18},
//         {"string": "stephanie", "integer": 13}
//        ]
// Output: 8.3
// Example 02

// Input: []
// Output: 0.0
// Tips
// (In Javascript)
// For javascript user in order to get the right precision of the floating number, use toFixed().
// Google the following: Float variable type
// Google the following: what is a Hash (look at dictionary or technical definition and use cases)
// Google the following: Object.keys(hash)


/*
**
** QWASAR.IO -- my_average_mark
**
**
** @param {String_integer[]} param_1
** @return {float}

**
*/


function my_average_mark(score){
    let result = 0;
    if (score.length === 0){
        return 0.0;
    }
   
    for (let i = 0; i < score.length; i++){
       
        result += score[i]["integer"];
        average = result / score.length
    }

    return average.toFixed(1)
}

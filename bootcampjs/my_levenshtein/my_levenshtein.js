// Your job is to write an algorithm that calculates the Qwasar version of a Levenshtein number between two words.

// The Qwasar version of a Levenshtein number is simple: it's a value that represents how similar two given strings are.
// It is found by comparing two strings and returning the difference between them. (For information, the Levenshtein number is a real concept but we've simplified it a bit for the purposes of this exercise.)

// Let’s look at the following example:

//   abc
//   dbc
//   ^  
// The Levenshtein difference between these two strings is 1. The two strings are almost identical, other than one letter. That letter, 'd’, is close to the example, 'a’, meaning the Levenshtein value will be small.

// Instructions
// Your function must take in 2 strings with the exact number of characters and return an integer representing the difference between them.

// If your parameters are not the same size then your function will return -1.

// If the two strings are the same size, you must then iterate through each string and determine which characters are different. Each time there is a difference, it counts as 1.


function my_levenshtein(fstr, sstr){
    let num = 0;
    if (fstr.length === sstr.length){
        for (let i = 0; i < fstr.length; i++){
            if (fstr[i] !== sstr[i]){
                num++;
            }
        }
    }else {
        if (fstr.length !== sstr.length){
            return -1
        }
    }

    return num;

}

console.log(my_levenshtein("", "GGACTGA"))
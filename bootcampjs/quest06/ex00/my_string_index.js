// Description
// Create a my_string_index function which takes 2 parameters (haystack and needle) and locates the first occurrence of the character needle in the string haystack and returns the position.

// You can think of this function as: is there an L (character) in my string "helLo"?

// The objective is to build a loop that has an if statement which returns the characters position when it matches the right character.

// Function prototype (javascript)
// /*
// **
// ** QWASAR.IO -- my_string_index
// **
// **
// ** @param {String} param_1
// ** @param {Character} param_2
// ** @return {integer}

// **
// */


function my_string_index(haystack, needle) {
    var index = 0;
    
    while (index < haystack.length) {
        if (haystack[index] === needle) {
            return index;

        }
        index += 1;
    }
    return -1;
};

console.log(my_string_index("aaaa", "b"))

// Example 00

// Input: "hello" && "l"
// Output: 
// Return Value: 2
// Example 01

// Input: "aaaaa" && "b"
// Output: 
// Return Value: -1
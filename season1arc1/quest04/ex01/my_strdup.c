// Let's allocate a string (or array of characters).

// We have the string: "abc" and we want a copy in a new part of memory that you will have to malloc.

// (Reproduce the behavior of strdup from man strdup)

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_strdup
// **
// ** @param {char*} param_1
// **
// ** @return {char*}
// **
// */

// char* my_strdup(char* param_1)
// {

// }
// Example 00

// Input: "abc"
// Output: 
// Return Value: "abc"
// Example 01

// Input: "RaInB0"
// Output: 
// Return Value: "RaInB0"
// Example 02

// Input: ""
// Output: 
// Return Value: ""
// Tip
// (In C)
// Don't worry about free, it will be done in our main().

#include <stdlib.h>
#include <string.h>

char* my_strdup(char* param_1) {
    int len = strlen(param_1) + 1;
    char* dest = malloc(len * sizeof(char));
    if (dest) {
        strcpy(dest, param_1);
    }
    return dest;
}

// This function uses strlen to calculate the length of the input string param_1 and then allocate a new 
// block of memory using malloc that is large enough to store a copy of the string. The strcpy function is 
// then used to copy the contents of param_1 into the newly allocated memory. The function returns a pointer 
// to the newly allocated memory, which can be used as a string in the same way as param_1.
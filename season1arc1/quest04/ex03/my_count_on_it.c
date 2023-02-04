// Count the size of each elements in an array.

// Create a function my_count_on_it that receives a string array as a parameter and returns an array with the length of each string.

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_count_on_it
// **
// ** @param {string_array*} param_1
// **
// ** @return {integer_array*}
// **
// */
// #ifndef STRUCT_STRING_ARRAY
// #define STRUCT_STRING_ARRAY
// typedef struct s_string_array
// {
//     int size;
//     char** array;
// } string_array;
// #endif

// #ifndef STRUCT_INTEGER_ARRAY
// #define STRUCT_INTEGER_ARRAY
// typedef struct s_integer_array
// {
//     int size;
//     int* array;
// } integer_array;
// #endif


// integer_array* my_count_on_it(string_array* param_1)
// {

// }
// Example 00

// Input: ["This", "is", "the", "way"]
// Output: 
// Return Value: [4, 2, 3, 3]
// Example 01

// Input: ["aBc", "AbcE Fgef1"]
// Output: 
// Return Value: [3, 10]
// Example 02

// Input: ["aBc"]
// Output: 
// Return Value: [3]
// Tips
// Google while YOURCODINGLANGUAGE
// Google for YOURCODINGLANGUAGE
// Google array.length YOURCODINGLANGUAGE
// (In C)
// Yes, you have to allocate for the struct AND then allocate for the array inside. :-)

// (In C)
// Don't forget to set the size. ;-)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef STRUCT_STRING_ARRAY
#define STRUCT_STRING_ARRAY
typedef struct s_string_array
{
    int size;
    char** array;
} string_array;
#endif

#ifndef STRUCT_INTEGER_ARRAY
#define STRUCT_INTEGER_ARRAY
typedef struct s_integer_array
{
    int size;
    int* array;
} integer_array;
#endif

integer_array* my_count_on_it(string_array* param_1) {
    integer_array* result = malloc(sizeof(integer_array));
    result->size = param_1->size;
    result->array = malloc(sizeof(int) * result->size);
    int i;
    for (i = 0; i < result->size; i++) {
        result->array[i] = strlen(param_1->array[i]);
    }
    return result;
}

// This function starts by allocating memory for an integer_array structure, which will be the result. 
// It sets the size member of the result to be the same as the size member of the input param_1. Then, 
// it allocates memory for the array member of the result, which will store the length of each string.

// Next, the function uses a loop to iterate over each string in the input param_1. For each string, 
// it uses the strlen function to find the length of the string and stores the result in the corresponding 
// position in the result's array member.

// Finally, the function returns the result.
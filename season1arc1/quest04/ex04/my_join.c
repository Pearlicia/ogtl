// Create a function that combines an array of strings from separator characters.

// ["Hello", "World", "!"] && ' '
// => "Hello World !"
// You will receive two parameters, an array with all the strings and a separator.

// The function should return a string where all the strings from the array are joined with the separator.

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_join
// **
// ** @param {string_array*} param_1
// ** @param {char*} param_2
// **
// ** @return {char*}
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


// char* my_join(string_array* param_1, char* param_2)
// {

// }
// Example 00

// Input: ["abc", "def", "gh", "!"] && "-"
// Output: 
// Return Value: "abc-def-gh-!"
// Example 01

// Input: ["abc", "def", "gh", "!"] && "blah"
// Output: 
// Return Value: "abcblahdefblahghblah!"
// Example 02

// Input: ["abc", "def", "gh", "!"] && ""
// Output: 
// Return Value: "abcdefgh!"
// Example 03

// Input: [] && " "
// Output: 
// Return Value: nil

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

char* my_join(string_array* param_1, char* param_2)
{
    int total_size = 0;
    int separator_size = strlen(param_2);
    int i;
    char *result;
    
    if (param_1->size == 0)
        return NULL;
    for (i = 0; i < param_1->size; i++)
        total_size += strlen(param_1->array[i]);
    total_size += separator_size * (param_1->size - 1);
    result = (char *)malloc(total_size + 1);
    if (result == NULL)
        return NULL;
    strcpy(result, param_1->array[0]);
    for (i = 1; i < param_1->size; i++) {
        strcat(result, param_2);
        strcat(result, param_1->array[i]);
    }
    return result;
}

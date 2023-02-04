// ["Hello", "World", "."]

// Create a function that displays the content of an array of strings.
// One word per line.

// Each word will be followed by a newline, including the last one.

// (You can't use printf, time to reuse your my_putstr function ;-))

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_print_words_array
// **
// ** @param {string_array*} param_1
// **
// ** @return {void}
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


// void my_print_words_array(string_array* param_1)
// {

// }
// Example 00

// Input: ["abc", "def", "gh"]
// Output: abc
// def
// gh

// Return Value: nil
// Example 01

// Input: ["123"]
// Output: 123

// Return Value: nil
// Example 02

// Input: ["", "", "hello"]
// Output: 

// hello

// Return Value: nil

#include <stdio.h>
#ifndef STRUCT_STRING_ARRAY
#define STRUCT_STRING_ARRAY
typedef struct s_string_array
{
    int size;
    char** array;
} string_array;
#endif

void my_putstr(char* str) {
    int i = 0;
    while (str[i]) {
        putchar(str[i++]);
    }
}

void my_print_words_array(string_array* param_1) {
    int i;
    for (i = 0; i < param_1->size; i++) {
        my_putstr(param_1->array[i]);
        putchar('\n');
    }
}


// This function uses a loop to iterate over each string in the array member of the string_array 
// structure param_1. For each string, it calls my_putstr to print the string and then prints a
//  newline character using putchar('\n').
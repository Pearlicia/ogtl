// Let's create a function which will tell us if an array is sorted or not. What is sorted? :-)

// Write a function that takes an integer array as a parameter (input) and returns a boolean (true/false).

// Your function should return true if the integer array is sorted in either ASC(ascending) or DESC(descending) order.
// Your function should return false if the integer array is not sorted.

// Numbers will be from -2_000_000 to 2_000_000
// The array might have duplicates.

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_is_sort
// **
// ** @param {integer_array*} param_1
// **
// ** @return {bool}
// **
// */
// #include <stdbool.h>
// #ifndef STRUCT_INTEGER_ARRAY
// #define STRUCT_INTEGER_ARRAY
// typedef struct s_integer_array
// {
//     int size;
//     int* array;
// } integer_array;
// #endif


// bool my_is_sort(integer_array* param_1)
// {

// }
// Example 00

// Input: [1, 1, 2]
// Output: 
// Return Value: true
// Example 01

// Input: [2, 1, -1]
// Output: 
// Return Value: true
// Example 02

// Input: [4, 7, 0, 3]
// Output: 
// Return Value: false
// Example 03

// Input: []
// Output: 
// Return Value: true
// Tips
// (In C)
// In C, we have defined boolean on char so you can use the type boolean :)
// (In C)
// Curious about the integer_array type?

// typedef struct s_integer_array {
//   int size;
//   int* array;
// } integer_array;
// integer_array_variable->size
// will give you the size of the array

// integer_array_variable->array
// will give you the access to the array

// integer_array_variable->array[0]
// => is the first cell of the array

// Please do not define the struct in your code when sending to gandalf.


#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
// #include <struct_integer_array.h>

#ifndef STRUCT_INTEGER_ARRAY
#define STRUCT_INTEGER_ARRAY
typedef struct s_integer_array
{
    int size;
    int* array;
} integer_array;
#endif

bool my_is_sort(integer_array* param_1)
{
    if (param_1 == NULL || param_1->size <= 1)
        return true;
    
    int direction = param_1->array[1] - param_1->array[0];
    for (int i = 1; i < param_1->size - 1; i++)
    {
        int diff = param_1->array[i + 1] - param_1->array[i];
        if (direction == 0)
            direction = diff;
        else if (direction > 0 && diff < 0 || direction < 0 && diff > 0)
            return false;
    }
    return true;
}

// Explanation:

// First, the function checks if the input array is NULL or has 0 or 1 element. If it's the case, it returns true, as an array with 0 or 1 element is considered sorted by definition.

// Then, the function calculates the direction of the array (ascending or descending) by checking the difference between the first two elements.

// The function then iterates through the array starting from the second element, checking if the current difference between two consecutive elements has the same sign as the direction. If the sign is different, the array is not sorted, so the function returns false.

// Finally, if the function has not returned false in the loop, it means the array is sorted, so the function returns true.
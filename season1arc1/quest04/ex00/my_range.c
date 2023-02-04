// Create a function my_range which returns a malloc'd array of integers. This integer array should contain all values between min and max.

// Min included - max excluded.

// If min value is greater or equal to max's value, a null pointer should be returned.

// Don't worry about "free", it will be done in our main().

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_range
// **
// ** @param {int} param_1
// ** @param {int} param_2
// **
// ** @return {int*}
// **
// */

// int* my_range(int param_1, int param_2)
// {

// }
// Example 00

// Input: 1 && 4
// Output: 
// Return Value: [1, 2, 3]
// Example 01

// Input: 7 && 10
// Output: 
// Return Value: [7, 8, 9]
// Example 02

// Input: 10 && 11
// Output: 
// Return Value: [10]

#include <stdlib.h>

int* my_range(int param_1, int param_2)
{
  if (param_1 >= param_2)
    return NULL;
  int size = param_2 - param_1;
  int* arr = (int*) malloc(sizeof(int) * size);
  for (int i = 0; i < size; i++)
    arr[i] = param_1 + i;
  return arr;
}

#include <unistd.h>

int my_putchar(char c) {
  return write(1, &c, 1);
}

void my_putstr(char* param_1)
{
    int i = 0;
    while (param_1[i] != '\0')
    {
        my_putchar(param_1[i]);
        i++;
    }
}

// Create a function that displays a string of characters on the standard output.
// The address of the string's first character is in the pointer entered as
// parameter in the function.

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_putstr
// **
// ** @param {char*} param_1
// **
// ** @return {void}
// **
// */

// void my_putstr(char* param_1)
// {

// }
// Example 00

// Input: "abc"
// Output: abc
// Return Value: nil
// Example 01

// Input: "abcdelele dzp ll 0"
// Output: abcdelele dzp ll 0
// Return Value: nil
// Example 02

// Input: ""
// Output: 
// Return Value: nil


// (In C)
// Remember \0 is the End Of String
// (In C)
// To print a character you can use my_putchar

// int my_putchar(char c) {
//   return write(1, &c, 1);
// }

// Searches for the last occurrence of the character c (an unsigned char) in the string pointed to by the argument str. The terminating null character is considered to be part of the string. Returns a pointer pointing to the last matching character, or null if no match was found.

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_strrchr
// **
// ** @param {char*} param_1
// ** @param {char} param_2
// **
// ** @return {char*}
// **
// */

// char* my_strrchr(char* param_1, char param_2)
// {

// }
// Example 00

// Input: "abcabc" && "b"
// Output: 
// Return Value: "bc"
// Example 01

// Input: "121212" && "2"
// Output: 
// Return Value: "2"
// Example 02

// Input: "abc" && "d"
// Output: 
// Return Value: nil

#include <string.h>
#include <stdlib.h>

char* my_strrchr(char* str, char c)
{
    char* result = NULL;
    while (*str != '\0')
    {
        if (*str == c)
        {
            result = str;
        }
        str++;
    }
    return result;
}

// Reproduce the behavior of the function strcpy.
// The strcpy() and strncpy() functions copy the string source (src) to destination (dst).

// The first parameter is the destination and the second parameter is the source.
// The strcpy() and strncpy() functions return destination.

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_strcpy
// **
// ** @param {char*} param_1
// ** @param {char*} param_2
// **
// ** @return {char*}
// **
// */

// char* my_strcpy(char* param_1, char* param_2)
// {

// }
// Example 00

// Input: "" && "abc"
// Output: 
// Return Value: "abc"
// Example 01

// Input: "" && "RaInB0w d4Sh! "
// Output: 
// Return Value: "RaInB0w d4Sh! "
// Example 02

// Input: "" && ""
// Output: 
// Return Value: ""
// Tip
// (In C)

// /*
// Example of main
// */
// #include <stdio.h>

// int main() {
//   char dst[100] = {0};
//   char *src     = "Hello";
  
//   printf("my_strcpy -> %s\n", my_strcpy(dst, src));
//   return 0;
// }

char* my_strcpy(char* param_1, char* param_2)
{
    int i = 0;
    while (param_2[i] != '\0') {
        param_1[i] = param_2[i];
        i++;
    }
    param_1[i] = '\0';
    return param_1;
}

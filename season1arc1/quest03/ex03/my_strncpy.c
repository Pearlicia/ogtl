// Reproduce the behavior of the function strncpy.

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_strncpy
// **
// ** @param {char*} param_1
// ** @param {char*} param_2
// ** @param {int} param_3
// **
// ** @return {char*}
// **
// */

// char* my_strncpy(char* param_1, char* param_2, int param_3)
// {

// }
// Example 00

// Input: "" && "abc" && 2
// Output: 
// Return Value: "ab"
// Example 01

// Input: "" && "RaInB0w d4Sh! " && 6
// Output: 
// Return Value: "RaInB0"
// Example 02

// Input: "" && "Hello World" && 0
// Output: 
// Return Value: ""

char* my_strncpy(char* param_1, char* param_2, int param_3)
{
    int i = 0;
    while (i < param_3 && param_2[i] != '\0') {
        param_1[i] = param_2[i];
        i++;
    }
    while (i < param_3) {
        param_1[i] = '\0';
        i++;
    }
    return param_1;
}

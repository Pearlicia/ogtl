// Description
// Reproduce the behavior of the function strcmp.
// The strcmp() function compares string1 with string2 to see if there are equals.

// Tip
// Return value is connected to ASCII values ;-)

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_strcmp
// **
// ** @param {char*} param_1
// ** @param {char*} param_2
// **
// ** @return {int}
// **
// */

// int my_strcmp(char* param_1, char* param_2)
// {

// }
// Example 00

// Input: "abc" && "bd"
// Output: 
// Return Value: -1
// Example 01

// Input: "bd" && "abc"
// Output: 
// Return Value: 1
// Example 02

// Input: "abc" && "abc"
// Output: 
// Return Value: 0
// Tip
// (In C)

// /*
// Example of main
// */
// int main() {
//   char *s1 = "Hello";
//   char *s2 = "Hello";
  
//   printf("my_strcmp -> %d\n", my_strcmp(s1, s2));
//   return 0
// }


int my_strcmp(char* param_1, char* param_2)
{
    int i = 0;
    while (param_1[i] == param_2[i] && param_1[i] != '\0') {
        i++;
    }
    return (unsigned char)param_1[i] - (unsigned char)param_2[i];
}

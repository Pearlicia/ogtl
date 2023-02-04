// Write a program that takes a string as an argument and returns it reversed.

// Your algorithm must be IN PLACE. (What is in place?)
// An in-place algorithm is an algorithm which transforms input using no auxiliary data structure.

// Example 00:

// Input: "Hello"
// Output: "olleH"
// Example 01:

// Input: "LoL"
// Output: "LoL"
// Example 02:

// Input: "Nothing Else Matters"
// Output: "srettaM eslE gnihtoN"
// Example 03:

// Input: ""
// Output: ""
// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- reverse_string
// **
// ** @param {char*} param_1
// **
// ** @return {char*}
// **
// */

// char* reverse_string(char* param_1)
// {

// }
// Tip
// (In C)

// /*
// Example of main
// */
// int main() {
//   char my_str[] = "Hello";
  
//   printf("Before reverse -> %s
// ", my_str);
//   printf("Reverse -> %s
// ", reverse_string(my_str));
//   return 0;
// }


char* reverse_string(char* str) {
    int n = strlen(str);
    for (int i = 0; i < n / 2; i++) {
        char temp = str[i];
        str[i] = str[n - i - 1];
        str[n - i - 1] = temp;
    }
    return str;
}

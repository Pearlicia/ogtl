// Implement strStr().

// It should return a pointer to the first occurrence of a needle in a haystack, or NULL if the needle is not part of the haystack.

// Clarification:

// What should we return when needle is an empty string? This is a great question to ask during an interview.

// For the purpose of this problem, we will return haystack when needle is an empty string.

// Function prototype (c)
// /*
// **
// ** QWASAR.IO -- my_strstr
// **
// ** @param {char*} param_1
// ** @param {char*} param_2
// **
// ** @return {char*}
// **
// */

// char* my_strstr(char* param_1, char* param_2)
// {

// }
// Example 00

// Input: "hello" && "ll"
// Output: 
// Return Value: "llo"
// Example 01

// Input: "aaaaa" && "bba"
// Output: 
// Return Value: nil
// Example 02

// Input: "" && "a"
// Output: 
// Return Value: nil
// Tip
// (In C)
// pseudo-code:

// while letter_s1 in s1
//   while letter_s2 in s2
//     if letter_s1 != letter_s2
//       break
//   if reach end of s2
//     return &s1[index]
// return NULL

#include <string.h>
#include <stdlib.h>

char* my_strstr(char* haystack, char* needle) {
    int haystack_len = strlen(haystack);
    int needle_len = strlen(needle);

    for (int i = 0; i < haystack_len - needle_len + 1; i++) {
        int j = 0;
        for (j = 0; j < needle_len; j++) {
            if (haystack[i + j] != needle[j]) {
                break;
            }
        }
        if (j == needle_len) {
            return &haystack[i];
        }
    }
    return NULL;
}

// Explanation:

// First, we get the length of both the haystack and needle strings using strlen.
// We then loop through the haystack string starting from the first character, up to the last possible start index of the needle (haystack_len - needle_len + 1).
// In the inner loop, we compare each character of the needle string with the corresponding characters in the haystack string, starting from the current start index. If all characters match, it means we have found the first occurrence of the needle in the haystack and we return a pointer to it (&haystack[i]).
// If we reach the end of the haystack string without finding a match, we return NULL.
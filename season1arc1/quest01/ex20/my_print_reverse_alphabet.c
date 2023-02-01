#include <stdio.h>

void my_print_reverse_alphabet() {
    for (int i = 'z'; i >= 'a'; i--) {
        putchar(i);
    }
    putchar('\n');
}

// Create a function that displays the alphabet in lowercase on a single line in descending order starting from the letter z.
// It will be followed by a   (newline character).

// This implementation uses a for loop to iterate through the letters 'z' to 'a', in reverse order, and the putchar() function to print each letter. 
// The loop stops when the letter 'a' is reached, and then a newline character is printed to start a new line.

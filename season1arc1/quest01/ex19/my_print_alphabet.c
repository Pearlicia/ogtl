#include <stdio.h>

void my_print_alphabet() {
    for (int i = 'a'; i <= 'z'; i++) {
        putchar(i);
    }
    putchar('\n');
}

// Create a function that displays the alphabet in lowercase on a single line in ascending order starting from the letter a.
// It will be followed by a   (newline character).

// Function prototype (c)

// This implementation uses a for loop to iterate through the letters 'a' to 'z', 
// and the putchar() function to print each letter. The loop stops when the letter 'z' is 
// reached, and then a newline character is printed to start a new line.
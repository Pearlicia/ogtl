// It's your turn to code the software cat!

// Create a program called my_cat which does the same thing as the system's cat command used in the command-line.

// Your program should read the content of each files which are received as an argument to your software.
// Unlike the real Cat command, you don't have to handle any options. :-)

// [[examples]]
// language = "Javascript"

// $>node my_cat file1
// content_file_1
// content_file_2
// $>
// Example Python

// $>python my_cat file1 file2
// content_file_1
// content_file_2
// $>
// Example Ruby

// $>ruby my_cat file1 file2
// content_file_1
// content_file_2
// $>
// Example java

// $>java my_cat file1 file2
// content_file_1
// content_file_2
// $>
// Example Rust <3

// $>./my_cat file1 file2
// content_file_1
// content_file_2
// $>

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
    if (argc < 2) {
        printf("my_cat: missing file operand\n");
        return 1;
    }

    for (int i = 1; i < argc; i++) {
        FILE* file = fopen(argv[i], "r");
        if (!file) {
            printf("my_cat: %s: No such file or directory\n", argv[i]);
            return 1;
        }

        int c;
        while ((c = getc(file)) != EOF) {
            putchar(c);
        }

        fclose(file);
    }

    return 0;
}

// This program takes the file names as command line arguments, opens each file in turn, 
// and reads its contents character by character until the end of file (EOF) is reached. I
// t then closes the file and moves on to the next file. If the file could not be opened, an error message is displayed.
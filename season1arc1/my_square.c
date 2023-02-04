#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include <stdio.h>
#include <stdlib.h>

void draw_line(int length, char symbol) {
    for (int i = 0; i < length; i++) {
        putchar(symbol);
    }
}

void draw_square(int x, int y) {
    for (int i = 0; i < y; i++) {
        if (i == 0 || i == y - 1) {
            putchar('o');
            draw_line(x - 2, '-');
            putchar('o');
        } else {
            putchar('|');
            draw_line(x - 2, ' ');
            putchar('|');
        }
        putchar('\n');
    }
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s x y\n", argv[0]);
        return 1;
    }
    int x = atoi(argv[1]);
    int y = atoi(argv[2]);
    draw_square(x, y);
    return 0;
}


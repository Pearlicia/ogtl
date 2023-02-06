// This one passed all 6
#include <stdio.h>
#include <stdlib.h>

void my_square(int x, int y) {
  int i, j;
  if (x <= 0 || y <= 0) {
    return;
  }
  printf("o");
  for (i = 0; i < x - 2; i++) {
    printf("-");
  }
  printf("o\n");
  for (i = 0; i < y - 2; i++) {
    printf("|");
    for (j = 0; j < x - 2; j++) {
      printf(" ");
    }
    printf("|\n");
  }
  printf("o");
  for (i = 0; i < x - 2; i++) {
    printf("-");
  }
  printf("o\n");
}

int main(int argc, char **argv) {
  int x, y;
  if (argc < 3) {
    return 0;
  }
  x = atoi(argv[1]);
  y = atoi(argv[2]);
  my_square(x, y);
  return 0;
}



// first c code
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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



// c converted to js
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

// js

function drawLine(length, symbol) {
    let line = '';
    for (let i = 0; i < length; i++) {
      line += symbol;
    }
    return line;
  }
  
  function drawSquare(x, y) {
    let square = '';
    for (let i = 0; i < y; i++) {
      if (i === 0 || i === y - 1) {
        square += 'o' + drawLine(x - 2, '-') + 'o\n';
      } else {
        square += '|' + drawLine(x - 2, ' ') + '|\n';
      }
    }
    return square;
  }
  
  let x = parseInt(process.argv[2]);
  let y = parseInt(process.argv[3]);
  console.log(drawSquare(x, y));
  
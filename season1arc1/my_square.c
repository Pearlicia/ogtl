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

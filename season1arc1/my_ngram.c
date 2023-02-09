#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define HIGHEST_CHARACTERS 128

int main(int argc, char *argv[]) {
  int count_characters[HIGHEST_CHARACTERS];
  memset(count_characters, 0, sizeof count_characters);

  for (int i = 1; i < argc; i++) {
    char *text = argv[i];
    int text_len = strlen(text);

    for (int j = 0; j < text_len; j++) {
      count_characters[(int)text[j]]++;
    }
  }

  for (int i = 0; i < HIGHEST_CHARACTERS; i++) {
    if (count_characters[i] > 0) {
      printf("%c:%d\n", (char)i, count_characters[i]);
    }
  }

  return 0;
}

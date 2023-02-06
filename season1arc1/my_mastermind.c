#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_ATTEMPTS 10

char *generate_code() {
  char *code = malloc(5);
  int i;
  for (i = 0; i < 4; i++) {
    code[i] = (char)(rand() % 9 + '0');
  }
  code[4] = '\0';
  return code;
}

int main(int argc, char *argv[]) {
  srand(time(NULL));
  int attempts = MAX_ATTEMPTS;
  char *code = generate_code();
  int opt;
  while ((opt = getopt(argc, argv, "c:t:")) != -1) {
    switch (opt) {
      case 'c':
        code = optarg;
        break;
      case 't':
        attempts = atoi(optarg);
        break;
      default:
        printf("Usage: %s [-c CODE] [-t ATTEMPTS]\n", argv[0]);
        exit(EXIT_FAILURE);
    }
  }
  printf("Will you find the secret code?\nPlease enter a valid guess\n");
  char guess[5];
  int well_placed, misplaced;
  int i;
  for (i = 0; i < attempts; i++) {
    printf("---\nRound %d\n> ", i + 1);
    if (fgets(guess, 5, stdin) == NULL) {
      printf("Exited due to End of File\n");
      exit(EXIT_SUCCESS);
    }
    if (strlen(guess) != 4) {
      printf("Wrong input!\n");
      i--;
      continue;
    }
    well_placed = misplaced = 0;
    int j;
    for (j = 0; j < 4; j++) {
      if (guess[j] == code[j]) {
        well_placed++;
      } else {
        int k;
        for (k = 0; k < 4; k++) {
          if (guess[j] == code[k]) {
            misplaced++;
            break;
          }
        }
      }
    }
    if (well_placed == 4) {
      printf("Congratz! You did it!\n");
      exit(EXIT_SUCCESS);
    }
    printf("Well placed pieces: %d\nMisplaced pieces: %d\n", well_placed, misplaced);
  }
  printf("You failed to find the secret code. Better luck next time!\n");
  exit(EXIT_SUCCESS);
}

// This code uses the getopt function to parse the options -c and -t. If no code is specified, a random code 
// is generated using the generate_code function. The player's guess is read from the standard input using
//  the fgets function. If the input is not 4 characters long, it is considered

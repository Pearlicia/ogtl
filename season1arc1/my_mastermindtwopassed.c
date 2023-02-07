#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>


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
    int j;
    int len = read(0, guess, 4);
    guess[len] = '\0';
    if (len == 0) {
        printf("Exited due to End of File\n");
        exit(EXIT_SUCCESS);
    }
    if (strlen(guess) != 4) {
      printf("Wrong input!\n");
      i--;
      continue;
    }
    well_placed = misplaced = 0;
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



Status             FAILURE       
 Execution Runtime  0.060659      
 Score              [==--] 2/4    


Checks detail Report:

    MY MASTERMIND IS THERE A     SUCCESS 
  COMMAND LINE INTERFACE WHERE           
     YOU CAN TYPE COMMAND?               



 MY MASTERMIND DOES IT LET YOU   SUCCESS 
 FIND THE CORRECT COMBINAISON?           



 MY MASTERMIND DOES IT SHOW YOU                                                                                                           FAILURE                                                                                                          
 WHEN YOU HAVE AN ERROR IN THE                                                                                                                                                                                                                             
          COMBINAISON?                                                                                                                                                                                                                                     

 Input                               it 'Does it show you when you have an error in the combinaison?' do                                                                                                                                                   
                                         gold_feedbacks = ["Well placed pieces: 0", "Misplaced pieces: 0", "Well placed pieces: 0", "Misplaced pieces: 4", "Well placed pieces: 2", "Misplaced pieces: 0", "Well placed pieces: 2", "Misplaced pieces: 2"] 
                                                                                                                                                                                                                                                           
                                         communicate_with("./my_mastermind -c 1234") do                                                                                                                                                                    
                                             send_command("5678")                                                                                                                                                                                          
                                             send_command("4321")                                                                                                                                                                                          
                                             send_command("1256")                                                                                                                                                                                          
                                             send_command("1243")                                                                                                                                                                                          
                                         end                                                                                                                                                                                                               
                                                                                                                                                                                                                                                           
                                         keep_only_feedbacks = cw_stdout.strip.split("\n").select { |line| line.index('Well placed pieces') or line.index('Misplaced pieces') }                                                                            
                                         keep_only_feedbacks = keep_only_feedbacks.collect { |line| line.gsub('>', '').strip }                                                                                                                             
                                                                                                                                                                                                                                                           
                                         gold_feedbacks.zip(keep_only_feedbacks).each do |user_feedback, gold_feedback|                                                                                                                                    
                                           expect(gold_feedback).to eq(user_feedback)                                                                                                                                                                      
                                         end                                                                                                                                                                                                               
                                         expect(did_it_segfaulted?).to be(false)                                                                                                                                                                           
                                     end                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                           
 Expected Output                 ""                                                                                                                                                                                                                        
 Expected Return Value                                                                                                                                                                                                                                     
 Output                                                                                                                                                                                                                                                    
                                 expected: "Well placed pieces: 0"                                                                                                                                                                                         
                                      got: "Well placed pieces: 1"                                                                                                                                                                                         
                                                                                                                                                                                                                                                           
                                 (compared using ==)                                                                                                                                                                                                       
                                                                                                                                                                                                                                                           
 Return Value                                                                                                                                                                                                                                              


 MY MASTERMIND DOES IT LET YOU                                                                                                                           FAILURE                                                                                                                          
  FIND THE CORRECT COMBINAISON                                                                                                                                                                                                                                                            
         COMPLEX CASE?                                                                                                                                                                                                                                                                    

 Input                               it 'Does it let you find the correct combinaison complex case?' do                                                                                                                                                                                   
                                                                                                                                                                                                                                                                                          
                                         communicate_with("./my_mastermind -c 1234") do                                                                                                                                                                                                   
                                             send_command("5678")                                                                                                                                                                                                                         
                                             send_command("4321")                                                                                                                                                                                                                         
                                             send_command("1234")                                                                                                                                                                                                                         
                                         end                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                          
                                         expect(cw_stdout.strip).to include("Congratz! You did it!")                                                                                                                                                                                      
                                         expect(did_it_segfaulted?).to be(false)                                                                                                                                                                                                          
                                     end                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                          
 Expected Output                 ""                                                                                                                                                                                                                                                       
 Expected Return Value                                                                                                                                                                                                                                                                    
 Output                          expected "Will you find the secret code?\nPlease enter a valid guess\n---\nRound 1\n> Well placed pieces: 0\nM...es: 1\nMisplaced pieces: 2\n---\nRound 4\n> Wrong input!\n---\nRound 4\n> Exited due to End of File" to include "Congratz! You did it!" 
                                 Diff:                                                                                                                                                                                                                                                    
                                 @@ -1,20 +1,39 @@                                                                                                                                                                                                                                        
                                 -Congratz! You did it!                                                                                                                                                                                                                                   
                                 +Will you find the secret code?                                                                                                                                                                                                                          
                                 +Please enter a valid guess                                                                                                                                                                                                                              
                                 +---                                                                                                                                                                                                                                                     
                                 +Round 1                                                                                                                                                                                                                                                 
                                 +> Well placed pieces: 0                                                                                                                                                                                                                                 
                                 +Misplaced pieces: 0                                                                                                                                                                                                                                     
                                 +---                                                                                                                                                                                                                                                     
                                 +Round 2                                                                                                                                                                                                                                                 
                                 +> Well placed pieces: 1                                                                                                                                                                                                                                 
                                 +Misplaced pieces: 2                                                                                                                                                                                                                                     
                                 +---                                                                                                                                                                                                                                                     
                                 +Round 3                                                                                                                                                                                                                                                 
                                 +> Well placed pieces: 1                                                                                                                                                                                                                                 
                                 +Misplaced pieces: 2                                                                                                                                                                                                                                     
                                 +---                                                                                                                                                                                                                                                     
                                 +Round 4                                                                                                                                                                                                                                                 
                                 +> Wrong input!                                                                                                                                                                                                                                          
                                 +---                                                                                                                                                                                                                                                     
                                 +Round 4                                                                                                                                                                                                                                                 
                                 +> Exited due to End of File                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                          
 Return Value                                                                                                                                                                                                                                                                             

</MY_MASTERMIND>
➜  project git:(dev) ✗ 
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define SAN_SIZE 4

int my_get_digit(char *str)
{
    int str_length = strlen(str); 

    for (int i = 0; i < str_length; i++)
    {
        if (!(str[i] >= '0' && str[i] <= '9')) 
            return 1; 
    }
    return 0; 
}


int *get_rnd_nums()
{
    int *coding = malloc(SAN_SIZE * sizeof(int));
    int gen_new_num[9] = {0};

    srand(time(NULL));
   
    for (int i = 0; i < SAN_SIZE; i++)
    {
        int my_int_num = rand() % 10; 

        while(gen_new_num[my_int_num] == 1){ 
            my_int_num = rand() % 10;
        }
        coding[i] = my_int_num;
        gen_new_num[my_int_num] = 1; 
    }
    return coding;

}


void str_convert_int(int* param_1, char* param_2)
{
    int i;
    char gen_new_num_str[2] = {0};
    for (i = 0; param_2[i] != '\0'; i++)
    {
        gen_new_num_str[0] = param_2[i];
        param_1[i] = atoi(gen_new_num_str);
    }
}

int main(int argc, char **argv) 
{
    int *hiding_code = malloc(SAN_SIZE * sizeof(char));
    int my_gen_a_new_num = 10, rounds = 0;
    int *predit = malloc(SAN_SIZE * sizeof(int));
    
    if (argc > 2)
    {
        if((my_get_digit(argv[2]) != 0) || (strlen(argv[2]) != 4)){ 
            printf("Wrong input %s passed\n", argv[2]);
            hiding_code = get_rnd_nums();
        }
        else
        {
            if(strcmp(argv[1], "-c") == 0)  
                str_convert_int(hiding_code, argv[2]);
                

            else if(strcmp(argv[1], "-t") == 0){ 
                my_gen_a_new_num = atoi(argv[2]);
            if (my_gen_a_new_num > 10)
                my_gen_a_new_num = 10;
            }
        }
    }
    else
       hiding_code = get_rnd_nums();

    printf("Will you find the secret code?\n");
    printf("Please enter a valid guess\n");

    while (my_gen_a_new_num > 0)
    {
        printf("\nRound %d\n", rounds);
        rounds ++;

        int well_placed = 0, misplaced = 0;
        char *buffering = malloc (5 * sizeof(char));
        if (buffering == NULL){
            printf("Memory Allocation failed!\n");
            return 1;
        }        
       
        ssize_t n = read(0, buffering, 5);
        if (n <= 4){ 
            my_gen_a_new_num --;
            break;
        }
        else
            buffering[n] = '\0';

        int my_int_num = atoi(buffering);
        if (my_int_num == 0) {
            printf("Wrong input passed.\n");
            my_gen_a_new_num --;
            continue;
        }
        else
            str_convert_int(predit, buffering);

        for (int i = 0; i < SAN_SIZE; i++) 
        {
            if (hiding_code[i] == predit[i])
                well_placed ++;
            else
            {
                for (int j = 0; j < SAN_SIZE; j++)
                {
                    if (hiding_code[i] == predit[j] && i != j)
                    {
                        misplaced ++;
                        break;
                    }
                }
            }
        }
        if (well_placed == 4)
            {
                printf("Congratz! You did it!\n");
                break;
            }
        else
            printf("Well placed pieces: %d\nMisplaced pieces: %d\n", well_placed, misplaced);
                 my_gen_a_new_num --;

        free(buffering);
    }
    free(hiding_code);
    free (predit);
    return 0;
}


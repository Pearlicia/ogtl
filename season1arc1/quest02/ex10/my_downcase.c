// Create a my_downcase function that takes a string as a parameter and returns the lowercase version of it.

// /*
// Example of main
// */
// int main() {
//   char *my_str = strdup("AbcE Fgef1");
  
//   printf("RANDOM CASE -> %s\n", my_str);
//   printf("DOWNCASE    -> %s\n", my_downcase(my_str));
//   return 0;
// }

char* my_downcase(char* str)
{
    int i = 0;
    while (str[i])
    {
        if (str[i] >= 'A' && str[i] <= 'Z')
            str[i] = str[i] - 'A' + 'a';
        i++;
    }
    return str;
}


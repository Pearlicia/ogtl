// // Create a my_upcase function that takes a string as a parameter and returns the uppercase version of it.

// #include <ctype.h>

// char* my_upcase(char* str)
// {
//     int i = 0;
//     while (str[i])
//     {
//         str[i] = toupper(str[i]);
//         i++;
//     }
// }

// /*
// Example of main
// */
// int main() {
//   char *my_str = strdup("AbcE Fgef1");
  
//   printf("RANDOM CASE -> %s\n", my_str);
//   printf("UPCASE      -> %s\n", my_upcase(my_str));
//   return 0;
// }

// Without using the toupper library

char* my_upcase(char* str)
{
    int i = 0;
    while (str[i])
    {
        if (str[i] >= 'a' && str[i] <= 'z')
            str[i] = str[i] - 32;
        i++;
    }
    return str;
}



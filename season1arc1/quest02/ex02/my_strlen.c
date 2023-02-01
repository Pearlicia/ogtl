// language Reproduce the behavior of the function strlen.
// The strlen() function computes the length of the string s.

// The strlen() function returns the number of characters.

int my_strlen(const char *p) {
   int length = 0;
   while (*p != '\0') {
      length++;
      p++;
   }
   return length;
}

// This function takes a pointer to a character string s as its parameter, represented by
// the const char *s syntax. The function uses a while loop to iterate through the string, 
// counting the number of characters until the null character '\0' is reached. The loop increments 
// the length counter and the s pointer on each iteration. Finally, the function returns the computed
// length of the string as a size_t value. The size_t type is an unsigned integer type used to represent the size of an object in bytes.
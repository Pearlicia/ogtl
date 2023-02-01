// Let's switch the contents of parameter A and parameter B. :-)

// Create a function that swaps the value of two integers whose addresses are entered as parameters.

void my_swap(int *a, int *b) {
   int temp = *a;
   *a = *b;
   *b = temp;
}

// This function takes two pointers to integers, int *a and int *b, as its parameters. The values stored at 
// the memory locations pointed to by a and b are swapped using a temporary variable temp. The value stored at
// the location pointed to by a is stored in temp, then the value stored at the location pointed to by b is
// stored in the location pointed to by a, and finally the original value stored in temp is stored in the 
// location pointed to by b. This effectively swaps the values of the two integers.
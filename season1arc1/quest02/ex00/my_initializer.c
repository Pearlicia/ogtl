void my_initializer(int* param_1){
      *param_1 = 0;
 
}

// int main() {
//   int variable_a = 12;

//   printf("%d\n", variable_a); // will print 12
//   my_initializer(&variable_a);
//   printf("%d\n", variable_a); // will print 0
//   return 0;
// }

// Description
// Create a function that takes a pointer to integer as a parameter, and sets the value to 0.

// This function takes a pointer to an integer as its parameter, represented by the int *ptr syntax.
// The *ptr syntax is used to access the value stored at the memory location pointed to by ptr.
// By setting this value to 0 using the = operator, the function sets the integer pointed to by ptr to 0.
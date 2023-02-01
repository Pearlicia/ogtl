// Bubble sort is a simple sorting algorithm that repeatedly steps through the list, 
// compares adjacent elements and swaps them if they are in the wrong order. The algorithm gets
// its name from the way smaller elements "bubble" to the top of the list.

// Here is an example of how you can implement bubble sort in C:


void bubble_sort(int arr[], int n) 
{ 
    int i, j; 
    for (i = 0; i < n-1; i++)       
       for (j = 0; j < n-i-1; j++)  
           if (arr[j] > arr[j+1]) 
              swap(&arr[j], &arr[j+1]); 
} 

void swap(int *xp, int *yp) 
{ 
    int temp = *xp; 
    *xp = *yp; 
    *yp = temp; 
} 

// This implementation of bubble sort works by repeatedly swapping the adjacent elements if they are in the wrong order. 
// The inner loop iterates over the array, while the outer loop performs multiple passes over the array until it is sorted.












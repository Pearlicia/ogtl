// Create a my_string_index function which takes 2 parameters (haystack and needle) and locates the first occurrence of the character needle in the string haystack and returns the position.

// You can think of this function as: is there an L (character) in my string "helLo"?

// The objective is to build a loop that has an if statement which returns the characters position when it matches the right character.


int my_string_index(char* haystack, char needle)
{
    int i = 0;
    while (haystack[i] != '\0')
    {
        if (haystack[i] == needle)
        {
            return i;
        }
        i++;
    }
    return -1;
}

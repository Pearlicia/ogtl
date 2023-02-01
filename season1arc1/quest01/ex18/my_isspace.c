int my_isspace(int sc) {
    if (sc == ' ' || sc == '\t' || sc == '\n' || sc == '\v' || sc == '\f' || sc == '\r') {
        return 1;
    } else {
        return 0;
    }
}


// This implementation checks if the character is a space (ASCII code 32), a horizontal tab (ASCII code 9), 
// a newline (ASCII code 10), a vertical tab (ASCII code 11), a form feed (ASCII code 12), or a carriage return 
// (ASCII code 13), which are the standard whitespace characters in C.
// Topic: 3 Integers

// Given 3 integers, return the middle value. You can use any language but you cannot use any external
// functions (max, min, etc). You must code everything yourself.

// Example: 
// If 3, 1, 2: Return 2
// If 4, 0, 2: Return 2
// If 5, 7, 9: Return 7

// Function Prototype in JS (you can do this in any language)

function threeIntegers(a, b, c) {
    if (a >= b) {
      if (b >= c) {
        return b; 
      } else if (a <= c) {
        return a; 
      } else {
        return c; 
      }
    } else {
      if (a >= c) {
        return a; 
      } else if (b <= c) {
        return b; 
      } else {
        return c; 
      }
    }
}

console.log(threeIntegers(3, 1, 2))
console.log(threeIntegers(4, 0, 2))
console.log(threeIntegers(5, 7, 9))

// echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

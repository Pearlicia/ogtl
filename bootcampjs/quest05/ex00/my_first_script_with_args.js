// Description
// Let's do our first loop statement!

// Create a file my_first_script_with_args.js.

// It will print any argument received to the script

// Example 00 (In Javascript)

// $>node my_first_script_with_args.js blah1 blah2 blah3
// blah1
// blah2
// blah3
// $>

// Tip
// Google the following: script in YOURCODINGLANGUAGE receiving arguments (argv)

args = process.args.slice(2);

index = 0;

while (index < args.length) {
    console.log(args[index]);
    index++
}
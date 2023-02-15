# Description
# What is a CSV? :-)
# It's a format that is used very often, Microsoft Excel uses it.
# It's a 2d array: row and column.
# Rows are separated by "line" (the character "
# "). Columns are separated by ",". (Separators can be different, they can also be ";")

# Your goal is to transform a string following the CSV format to a 2d array.

# Your function will take two arguments, the contents of a CSV as a string and a separator.
# Your function will return an array (line) of arrays (columns).

# In this assignment, you will have to determine how to transform a string into an array.

# Function prototype (ruby)
# ##
# ##
# ## QWASAR.IO -- my_csv_parser
# ##
# ##
# ## @param {String} param_1
# ## @param {String} param_2
# ##
# ## @return {string[][]}
# ##


# def my_csv_parser(param_1, param_2)

# end
# Example 00

# Input: "a,b,c,e\n1,2,3,4\n" && ","
# Output: 
# Return Value: [["a", "b", "c", "e"], ["1", "2", "3", "4"]]
# Tip

# lines = "column1,column2,column3\nvalue1,value2,value3\n".split("\n");
# console.log(lines);

# var index = 0;

# while (index < lines.length) {
#   var values = lines[index].split(',');
# }

def my_csv_parser(csv_string, separator)
    lines = csv_string.split("\n")
    result = []
    
    lines.each do |line|
      columns = line.split(separator)
      result << columns
    end
    
    result
end


# In this implementation, we first split the CSV string into an array of lines using the newline character "\n". 
# Then, for each line, we split it into an array of columns using the specified separator, and we append this array 
# of columns to the result array.

# For example, if you call my_csv_parser("a,b,c,e\n1,2,3,4\n", ","), it will return [['a', 'b', 'c', 'e'], ['1', '2', '3', '4']].

# Note that this implementation assumes that the CSV string is well-formed and does not contain any edge cases such as quoted 
# values, escaped characters, or line breaks within a field. If your CSV contains such edge cases, you may need to use a more
#  advanced CSV parsing library that can handle these situations.
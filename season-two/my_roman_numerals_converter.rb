# Description
# Write a function to convert normal numbers to Roman Numerals.

# The Romans wrote numbers using letters - I, V, X, L, C, D, M. (notice these letters have lots of straight lines and are hence easy to carve into stone tablets).

#  1  => I
# 10  => X
#  7  => VII
# There is no need to be able to convert numbers larger than about 3000.
# (The Romans themselves didn't tend to go any higher)

# Wikipedia says: Modern Roman numerals ... are written by expressing each
# digit separately starting with the left most digit and skipping any
# digit with a value of zero.

# To see this in practice, consider the number 1990.

# In Roman numerals 1990 is MCMXC:

# 1000=M
# 900=CM
# 90=XC

# 2008 is written as MMVIII:

# 2000=MM
# 8=VIII

# See also: http://www.novaroma.org/via_romana/numbers.html

# It will return a string with the roman numeral.

# Example 00

# Input: 14
# Output: 
# Return Value: "XIV"
# Example 01

# Input: 79
# Output: 
# Return Value: "LXXIX"
# Example 02

# Input: 845
# Output: 
# Return Value: "DCCCXLV"
# Example 03

# Input: 2022
# Output: 
# Return Value: "MMXXII"


def my_roman_numerals_converter(num)
    roman_map = {
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
    }
    
    roman_numeral = ""
    roman_map.each do |value, letter|
      while num >= value
        roman_numeral += letter
        num -= value
      end
    end
    roman_numeral
end
  
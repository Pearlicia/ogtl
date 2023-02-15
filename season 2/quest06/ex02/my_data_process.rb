# Description
# We have been provided with a dataset of sales from My Online Coffee Shop. It's a CSV (Comma Separated Values) (each column is separated by , and each line is separated by  ).
# Our goal will be to identify customers who are more likely to buy coffee online.

# This time we will need to create a function with code logic, not just return the solution hard coded. :D

# Data management is a hard problem. To better solve this hard problem, we will split them into smaller ones.

# Here is our second step: data transformation. This exercise follows step one.

# You will receive the output of your function my_data_transform.

# Our function will group the data and it will become a Hash of hash. (Wow.)
# Example:
# "{'Gender': {'Male': 22, 'Female': 21}, 'Email': {'yahoo.com': 3, 'hotmail.com': 2}, ...}"

# We will discard the column FirstName, LastName, UserName and Coffee Quantity from our output.

# Your function will be prototyped: def my_data_process
# It will take a string array which is the output of your function my_data_transform, it will return a json string of hash of hash following this format:
# {COLUMN: {Value1: nbr_of_occurence_of_value_1, Value2: nbr_of_occurence_of_value_2, ...}, ...}
# Order of Column will be the order they are in the header of the CSV (Gender first then Email, etc)
# Order of the Value will be the order they appear in each line from top left.
# Use STRINGS as keys (=> Do not use any symbol or any fancy things. It doesn't translate well in json. (no :Age => "Age"))

# Function prototype (ruby)
# ##
# ##
# ## QWASAR.IO -- my_data_process
# ##
# ##
# ## @param {String[]} param_1
# ##
# ## @return {string}
# ##


# def my_data_process(param_1)

# end
# Example 00

# Input: ["Gender,FirstName,LastName,UserName,Email,Age,City,Device,Coffee Quantity,Order At", "Male,Carl,Wilderman,carl,yahoo.com,21->40,Seattle,Safari iPhone,2,afternoon", "Male,Marvin,Lind,marvin,hotmail.com,66->99,Detroit,Chrome Android,2,afternoon", "Female,Shanelle,Marquardt,shanelle,hotmail.com,21->40,Las Vegas,Chrome,1,afternoon", "Female,Lavonne,Romaguera,lavonne,yahoo.com,66->99,Seattle,Chrome,2,morning", "Male,Derick,McLaughlin,derick,hotmail.com,41->65,Chicago,Chrome Android,1,afternoon"]
# Output:
# '{"Gender":{"Male":3,"Female":2},"Email":{"yahoo.com":2,"hotmail.com":3},"Age":{"21->40":2,"66->99":2,"41->65":1},"City":{"Seattle":2,"Detroit":1,"Las Vegas":1,"Chicago":1},"Device":{"Safari iPhone":1,"Chrome Android":2,"Chrome":2},"Order At":{"afternoon":4,"morning":1}}'


# require 'json'

# def my_data_process(data)
#   # Split the header line into columns
#   columns = data[0].split(',')

#   # Initialize an empty hash of hash to store the counts
#   counts = {}
#   columns.each do |column|
#     counts[column] = {}
#   end

# #   Loop over the data rows and update the counts
#   data[1..-1].each do |row|
#     values = row.split(',')
#     columns.each_with_index do |column, index|
#       if column != 'FirstName' && column != 'LastName' && column != 'UserName' && column != 'Coffee Quantity'
#         value = values[index]
#         if counts[column][value]
#           counts[column][value] += 1
#         else
#           counts[column][value] = 1
#         end
#       end
#     end
#   end

#   return counts
# end

require 'json'

def my_data_process(param_1)
  # Split the header row and the data rows
  header = param_1.first.split(",")
  data_rows = param_1[1..-1]

  # Exclude the columns to be discarded from the header
  header = header.reject { |col| col == "FirstName" || col == "LastName" || col == "UserName" || col == "Coffee Quantity" }

  # Initialize an empty hash for each column
  column_hash = {}
  header.each { |col| column_hash[col] = {} }

  # Count the occurrences of each value for each column
  data_rows.each do |row|
    values = row.split(",")
    values = values.reject.with_index { |_, idx| idx == 1 || idx == 2 || idx == 3 || idx == 8 } # exclude the values for the discarded columns
    header.each_with_index do |col, idx|
      if column_hash[col].key?(values[idx])
        column_hash[col][values[idx]] += 1
      else
        column_hash[col][values[idx]] = 1
      end
    end
  end

  # Convert the hash to a JSON string and return it
  column_hash.to_json
end

# Description
# We have been provided with a dataset of sales from My Online Coffee Shop. It's a CSV (Comma Separated Values) (each column is separated by , and each line is separated by  ).
# Our goal will be to identify customers who are more likely to buy coffee online.

# Data management is a hard problem. To better solve this hard problem, we will split them into smaller ones.

# Here is our first step: data prep.

# You noticed our CSV is composed of 3 columns we cannot group them easily: Email - Age - Order At.

# For the email, we will consider the provider.
# For the age column, we consider a group from [1->20] - [21->40] - [41->65] - [66->99]
# For the Order at column, we consider a group for [morning => 06:00am -> 11:59am] - [afternoon => 12:00pm -> 5:59pm] - [evening => 6:00pm -> 11:59pm]

# You will have to create a function that will replace the value in each of these columns with the correct actionable data. (ex: if the age is between 21 and 40, replace by "21->40")

# Order At is a little more tricky.

# Your function will be prototyped: def my_data_transform(csv_content)
# It will take a string which contains data in CSV format and it will return a string in CSV format with the column Email, Age and Order At transformed.

# Function prototype (ruby)
# ##
# ##
# ## QWASAR.IO -- my_data_transform
# ##
# ##
# ## @param {String} param_1
# ##
# ## @return {string[]}
# ##


# def my_data_transform(param_1)

# end
# Example 00

# Input: "Gender,FirstName,LastName,UserName,Email,Age,City,Device,Coffee Quantity,Order At\nMale,Carl,Wilderman,carl,wilderman_carl@yahoo.com,29,Seattle,Safari iPhone,2,2020-03-06 16:37:56\nMale,Marvin,Lind,marvin,marvin_lind@hotmail.com,77,Detroit,Chrome Android,2,2020-03-02 13:55:51\nFemale,Shanelle,Marquardt,shanelle,marquardt.shanelle@hotmail.com,21,Las Vegas,Chrome,1,2020-03-05 17:53:05\nFemale,Lavonne,Romaguera,lavonne,romaguera.lavonne@yahoo.com,81,Seattle,Chrome,2,2020-03-04 10:33:53\nMale,Derick,McLaughlin,derick,mclaughlin.derick@hotmail.com,47,Chicago,Chrome Android,1,2020-03-05 15:19:48\n"
# Output: ["Gender,FirstName,LastName,UserName,Email,Age,City,Device,Coffee Quantity,Order At", "Male,Carl,Wilderman,carl,yahoo.com,21->40,Seattle,Safari iPhone,2,afternoon", "Male,Marvin,Lind,marvin,hotmail.com,66->99,Detroit,Chrome Android,2,afternoon", "Female,Shanelle,Marquardt,shanelle,hotmail.com,21->40,Las Vegas,Chrome,1,afternoon", "Female,Lavonne,Romaguera,lavonne,yahoo.com,66->99,Seattle,Chrome,2,morning", "Male,Derick,McLaughlin,derick,hotmail.com,41->65,Chicago,Chrome Android,1,afternoon"]
# Tip
# (In Ruby)
# You should use object DateTime :-)

# DateTime.parse('2020-03-06 16:37:56', '%Y-%m-%d %H:%M:%S')

require 'date'

def my_data_transform(csv_content)
  # Split the CSV content into lines and process the header separately
  lines = csv_content.strip.split("\n")
  header = lines.shift

  # Create a hash to map email providers to categories
  email_providers = {
    "yahoo.com" => "yahoo.com",
    "hotmail.com" => "hotmail.com",
    "gmail.com" => "gmail.com",
    "outlook.com" => "outlook.com",
    "aol.com" => "aol.com"
  }

  # Create a hash to map times of day to categories
  order_times = {
    morning: "morning",
    afternoon: "afternoon",
    evening: "evening"
  }

  # Process each line of the CSV content
  lines.map! do |line|
    # Split the line into fields and extract the email, age, and order time
    fields = line.split(",")
    email = fields[4]
    age = case fields[5].to_i
          when 1..20 then "1->20"
          when 21..40 then "21->40"
          when 41..65 then "41->65"
          when 66..99 then "66->99"
          else ""
          end
    order_time = DateTime.parse(fields[9], '%Y-%m-%d %H:%M:%S').strftime('%H:%M:%S')
    if order_time >= "06:00:00" && order_time <= "11:59:59"
      order_time_category = order_times[:morning]
    elsif order_time >= "12:00:00" && order_time <= "17:59:59"
      order_time_category = order_times[:afternoon]
    else
      order_time_category = order_times[:evening]
    end

    # Map the email provider and order time to categories
    email_provider = email.split("@").last
    email_category = email_providers[email_provider] || "other"

    # Replace the email, age, and order time fields with the categories
    fields[4] = email_category
    fields[5] = age
    fields[9] = order_time_category
    fields.join(",")
  end

  # Prepend the header back to the lines and return the transformed CSV content
  [header] + lines
end



# This implementation first splits the CSV content into lines and processes the header separately. 
# It then creates two hash maps to map email providers and times of day to categories. For the age column, 
# it uses a case statement to map ages to categories. It then processes each line of the CSV content,
# extracts the email, age, and order time fields, and maps them to categories using the hash maps.
# Finally, it replaces the email, age, and order time fields with the categories, joins the fields
# back into a line, and appends the line to the list of transformed lines. The function then prepends
# the header back to the list of lines and returns the transformed CSV content as a list of strings.
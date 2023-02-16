# escription
# Create a class MySelectQuery.
# Your constructor will receive a CSV content (as a string), first line will be the name of the column.

# Example:

# "name,year_start,year_end,position,height,weight,birth_date,college\nAlaa Abdelnaby,1991,1995,F-C,6-10,240,'June 24, 1968',Duke University\nZaid Abdul-Aziz,1969,1978,C-F,6-9,235,'April 7, 1946',Iowa State University\nKareem Abdul-Jabbar,1970,1989,C,7-2,225,'April 16, 1947','University of California, Los Angeles
# Mahmoud Abdul-Rauf,1991,2001,G,6-1,162,'March 9, 1969',Louisiana State University\n"
# It will be prototyped:

# constructor(csv_content)

# Implement a where method which will take 2 arguments: column_name and value.
# It will return an array of strings which matches the value.

# It will be prototyped:

# where(column_name, criteria)

# Our examples will use these CSV
# Nba Player Data
# Nba Players
# Nba Seasons Stats

# Example00

# Input: "name" && "Andre Brown"
# Output: ["Andre Brown,2007,2009,F,6-9,245,birth_date,May 12, 1981,'DePaul University'"]

# require 'csv'

# class MySelectQuery
#   def initialize(csv_content)
#     @data = CSV.parse(csv_content, headers: true)
#   end

#   def where(column_name, criteria)
#     @data.select { |row| row[column_name] == criteria }.map(&:to_s)
#   end
# end

class MySelectQuery
    def initialize(csv_content)
      @data = csv_content.split("\n")[1..].map { |row| row.split(",") }
      @header = csv_content.split("\n").first.split(",")
    end
    
    def where(column_name, criteria)
      index = @header.index(column_name)
      @data.select { |row| row[index] == criteria }.map { |row| row.join(",") }
    end
  end
  

#   This class takes a CSV content string as input and stores it as an array of arrays, where each inner array represents a row in the CSV. The first row of the CSV is used as the header. The where method takes a column name and a criteria value and returns an array of strings representing the rows that match the criteria.

  Example usage:
  csv_content = "name,year_start,year_end,position,height,weight,birth_date,college\nAlaa Abdelnaby,1991,1995,F-C,6-10,240,'June 24, 1968',Duke University\nZaid Abdul-Aziz,1969,1978,C-F,6-9,235,'April 7, 1946',Iowa State University\nKareem Abdul-Jabbar,1970,1989,C,7-2,225,'April 16, 1947','University of California, Los Angeles\nMahmoud Abdul-Rauf,1991,2001,G,6-1,162,'March 9, 1969',Louisiana State University\n"
query = MySelectQuery.new(csv_content)
query.where("name", "Alaa Abdelnaby") #=> ["Alaa Abdelnaby,1991,1995,F-C,6-10,240,'June 24, 1968',Duke University"]

require 'readline'
require_relative 'my_sqlite_request'

puts "MySQLite version 0.1 #{Time.now.strftime('%Y-%m-%d')}"

def get_input(prompt)
  Readline.readline(prompt, true).strip
end

def get_column_names(request)
  if request.instance_variable_defined?(:@select_columns)
    request.instance_variable_get(:@select_columns)
  else
    ['*']
  end
end

def display_results(results, request)
  column_names = get_column_names(request)
  puts column_names.join("\t")

  results.each do |row|
    puts column_names.map { |name| row[name] }.join("\t")
  end

  puts "#{results.count} rows in set"
end

def handle_select(request)
  results = request.run
  display_results(results, request)
end

def handle_insert(request)
  request.run
  puts "1 row inserted"
end

def handle_update(request)
  rows_updated = request.run
  puts "#{rows_updated} rows updated"
end

def handle_delete(request)
  rows_deleted = request.run
  puts "#{rows_deleted} rows deleted"
end

def handle_quit
  puts "Goodbye!"
  exit
end

loop do
  input = get_input('my_sqlite_cli> ')

  if input.empty?
    next
  end

  command, table_name, rest_of_input = input.split(/\s+/, 3)

  if command.nil?
    next
  end

  request = MySqliteRequest.new

  case command.downcase
  when 'select'
    request = request.from(table_name).select(rest_of_input)
    handle_select(request)

  when 'insert'
    data = rest_of_input.split(',').map(&:strip)
    request = request.insert(table_name).values(data)
    handle_insert(request)

  when 'update'
    update_values, where_clause = rest_of_input.split(/\s+where\s+/i)
    update_data = Hash[update_values.split(',').map(&:strip).map { |kv| kv.split(/\s*=\s*/) }]
    request = request.update(table_name).set(update_data)

    if where_clause
      column_name, criteria = where_clause.split(/\s+/, 2)
      request = request.where(column_name, criteria)
    end

    handle_update(request)

  when 'delete'
    if rest_of_input.downcase.start_with?('from')
      rest_of_input = rest_of_input[4..-1]
    end

    request = request.delete.from(table_name)

    if rest_of_input
      column_name, criteria = rest_of_input.split(/\s+/, 2)
      request = request.where(column_name, criteria)
    end

    handle_delete(request)

  when 'quit'
    handle_quit

  else
    puts "Unknown command: #{command}"
  end
end

require_relative 'my_sqlite_request.rb'

puts "MySQLite version 0.1 20XX-XX-XX"

loop do
  input = Readline.readline("my_sqlite_cli> ", true)
  break if input == "quit"

  # Parse input to determine the SQL command and extract relevant information

  case sql_command
  when "SELECT"
    request = MySqliteRequest.new
    request = request.from(table_name)
    request = request.select(column_names)
    request = request.where(condition)
    request.run
    # Display the result of the query to the user
  when "INSERT"
    request = MySqliteRequest.new
    request = request.insert(table_name)
    request = request.values(data)
    request.run
    # Display the result of the query to the user
  when "UPDATE"
    request = MySqliteRequest.new
    request = request.update(table_name)
    request = request.set(data)
    request = request.where(condition)
    request.run
    # Display the result of the query to the user
  when "DELETE"
    request = MySqliteRequest.new
    request = request.from(table_name)
    request = request.delete
    request = request.where(condition)
    request.run
    # Display the result of the query to the user
  else
    puts "Invalid command"
  end
end


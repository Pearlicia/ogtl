require_relative 'my_sqlite_request'

puts "MySQLite version 0.1 #{Time.now.strftime('%Y-%m-%d')}"
puts "Type 'quit' to exit."

loop do
  print 'my_sqlite_cli> '
  input = gets.chomp.strip.downcase

  break if input == 'quit'

  begin
    request = nil

    command, from_clause, where_clause, join_clause = input.split(/\s+(from|where|join)\s+/)

    if command == 'select'
      request = MySqliteRequest.from(from_clause).select('*')
      request = request.where(*where_clause.split('=').map(&:strip)) if where_clause
      request = request.join(*join_clause.split(/\s+on\s+/).map(&:strip)) if join_clause
      results = request.run
      puts results
    elsif command == 'insert'
      table_name, values = from_clause.split(/\s+values\s+/).map(&:strip)
      data = {}
      values.split(/\s*,\s*/).each do |pair|
        key, value = pair.split('=').map(&:strip)
        data[key] = value
      end
      request = MySqliteRequest.new.insert(table_name).values(data)
      request = request.where(*where_clause.split('=').map(&:strip)) if where_clause
      request.run
      puts "Inserted row into #{table_name}."
    elsif command == 'update'
      table_name, set_clause = from_clause.split(/\s+set\s+/).map(&:strip)
      data = {}
      set_clause.split(/\s*,\s*/).each do |pair|
        key, value = pair.split('=').map(&:strip)
        data[key] = value
      end
      request = MySqliteRequest.new.update(table_name).set(data)
      request = request.where(*where_clause.split('=').map(&:strip)) if where_clause
      request.run
      puts "Updated row(s) in #{table_name}."
    elsif command == 'delete'
      request = MySqliteRequest.from(from_clause).delete
      request = request.where(*where_clause.split('=').map(&:strip)) if where_clause
      request.run
      puts "Deleted row(s) from #{from_clause}."
    else
      puts "Invalid command: #{command}."
    end
  rescue => e
    puts "Error: #{e.message}"
  end
end

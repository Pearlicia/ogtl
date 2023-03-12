require_relative "my_sqlite_request"

class CLI
  def initialize
    @request = MySqliteRequest.new
    @running = true
  end

  def run
    puts "Welcome to your database CLI!"

    while @running
      print "Enter command: "
      input = gets.chomp

      case input
      when /^SELECT(.*)FROM(.*)WHERE(.*)/i
        handle_select($1.strip, $2.strip, $3.strip)
      when /^INSERT INTO(.*)VALUES(.*)/i
        handle_insert($1.strip, $2.strip)
      when /^UPDATE(.*)SET(.*)WHERE(.*)/i
        handle_update($1.strip, $2.strip, $3.strip)
      when /^DELETE FROM(.*)WHERE(.*)/i
        handle_delete($1.strip, $2.strip)
      when /^QUIT/i
        handle_quit
      else
        puts "Invalid command. Please try again."
      end
    end
  end

  private

  def handle_select(columns, table_name, where_conditions)
    @request.select_columns = columns.split(",").map(&:strip)
    @request.from(table_name.strip)
    @request.where_conditions = where_conditions.split("AND").map do |condition|
      column_name, criteria = condition.split("=").map(&:strip)
      [column_name, criteria]
    end

    results = @request.run

    if results.any?
      puts results
    else
      puts "No results found."
    end
  end

  def handle_insert(table_name, values)
    @request.insert(table_name.strip)

    data = {}

    values.split(",").each do |value|
      column_name, value = value.split("=").map(&:strip)
      data[column_name] = value
    end

    @request.values(data)

    @request.run

    puts "Data inserted."
  end

  def handle_update(table_name, set_data, where_conditions)
    @request.update(table_name.strip)

    data = {}

    set_data.split(",").each do |value|
      column_name, value = value.split("=").map(&:strip)
      data[column_name] = value
    end

    @request.set(data)
    @request.where_conditions = where_conditions.split("AND").map do |condition|
      column_name, criteria = condition.split("=").map(&:strip)
      [column_name, criteria]
    end

    @request.run

    puts "Data updated."
  end

  def handle_delete(table_name, where_conditions)
    @request.from(table_name.strip)
    @request.where_conditions = where_conditions.split("AND").map do |condition|
      column_name, criteria = condition.split("=").map(&:strip)
      [column_name, criteria]
    end

    @request.delete
    @request.run

    puts "Data deleted."
  end

  def handle_quit
    puts "Goodbye!"
    @running = false
  end
end

CLI.new.run

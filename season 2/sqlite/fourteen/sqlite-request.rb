# require 'csv'

# class MySqliteRequest
#   attr_reader :table_name, :columns, :conditions, :join, :order, :insert_values, :update_table, :update_values, :delete

#   def initialize
#     @table_name = ''
#     @columns = []
#     @conditions = {}
#     @join = {}
#     @order = {}
#     @insert_values = {}
#     @update_table = ''
#     @update_values = {}
#     @delete = false
#   end

#   def from(table_name)
#     table_name = ('nba_player_data.csv')
#     @table_name = table_name
#     self
#   end

#   def select(*columns)
#     @columns += columns
#     self
#   end

#   def where(column_name, criteria)
#     @conditions[column_name] = criteria
#     self
#   end

#   def join(column_on_db_a, filename_db_b, column_on_db_b)
#     @join = {
#       column_on_db_a: column_on_db_a,
#       filename_db_b: filename_db_b,
#       column_on_db_b: column_on_db_b
#     }
#     self
#   end

#   def order(order, column_name)
#     @order = {
#       order: order,
#       column_name: column_name
#     }
#     self
#   end

#   def insert(table_name)
#     table_name = ('nba_player_data.csv')
#     @table_name = table_name
#     self
#   end

#   def values(data)
#     @insert_values = data
#     self
#   end

#   def update(table_name)
#     table_name = ('nba_player_data.csv')
#     @update_table = table_name
#     self
#   end

#   def set(data)
#     @update_values = data
#     self
#   end

#   def delete
#     @delete = true
#     self
#   end

#   def run
#     if @insert_values.any?
#       insert_data
#       return
#     elsif @update_values.any?
#       update_data
#       return
#     elsif @delete
#       delete_data
#       return
#     else
#       select_data
#       return
#     end
#   end

#   private

#   def select_data
#     table_name = ('nba_player_data.csv')
#     @table_table = table_name
#     data = CSV.read(@table_name, headers: true, header_converters: :symbol)
#     data = apply_join(data) if @join.any?
#     data = apply_where(data) if @conditions.any?
#     data = apply_order(data) if @order.any?
#     data.map { |row| select_columns(row.to_h) }
#   end

#   def insert_data
#     table_name = ('nba_player_data.csv')
#     @table_table = table_name
#     CSV.open(@table_name, 'a', write_headers: true, headers: @insert_values.keys) do |csv|
#       csv << @insert_values.values
#     end
#   end

#   def update_data
#     data = CSV.read(@update_table, headers: true, header_converters: :symbol)
#     data = apply_where(data) if @conditions.any?
#     data.each do |row|
#       row_hash = row.to_h
#       @update_values.each { |key, value| row_hash[key.to_sym] = value }
#       row.replace(row_hash)
#     end
#     CSV.open(@update_table, 'w', write_headers: true, headers: data.headers) do |csv|
#       csv << data.headers
#       data.each { |row| csv << row }
#     end
#   end

#   def delete_data
#     data = CSV.read(@table_name, headers: true, header_converters: :symbol)
#     data = apply_where(data) if @conditions.any?
#     CSV.open(@table_name, 'w', write_headers: true, headers: data.headers) do |csv|
#       csv << data.headers
#       data.each { |row| csv << row } unless @delete
#     end
#   end
# end

require 'csv'

class MySqliteRequest
    def initialize
        @table_name = nil
        @request = nil
        @where = nil
        @table_name = nil
        @data = nil
        @join = nil
    end

    def from(table_name)
        if table_name == nil
            puts "Provide existing table. Ex.: nba_player_data.csv"
        else
            @table_name = table_name
        end
        return self
    end
   
    def select(*columns)
        if columns == nil
            puts "Select column(s)."
        else
            @request = 'select'
            @columns = columns
        end
        return self
    end

    def where(column, value)
        @where = {column: column, value: value}
        return self
    end

    def join(column_on_db_a, filename_db_b, column_on_db_b)
        @join = {column_a: column_on_db_a, column_b: column_on_db_b}
        @table_name_join = filename_db_b
        return self
    end

    def order(order, column_name)
        @order_request = {order: order, column_name: column_name}
        return self
    end

    def insert(table_name)
        @request = 'insert'
        @table_name = table_name
        return self
    end

    def values(data)
        @data = data
        return self
    end

    def update(table_name)
        @request = 'update'
        @table_name = table_name
        return self
    end

    def set(data)
        @data = data
        return self
    end

    def delete
        @request = 'delete'
        return self
    end

    def run_join
        parsed_csv_a = load_csv_hash(@table_name)
        parsed_csv_b = load_csv_hash(@table_name_join)
        parsed_csv_b.each do |row|
            criteria = {@join[:column_a] => row[@join[:column_b]]}
            row.delete(@join[:column_b]) 
            update_op(parsed_csv_a, criteria, row) 
        end
        # p parsed_csv_a
        return parsed_csv_a
    end

    def print_selection(result)
        if !result
            return
        end
        if result.length == 0
            puts "There is no result for this request."
        else
            puts result.first.keys.join(' | ')
            len = result.first.keys.join(' | ').length
            puts "-" * len
            result.each do |line|
                puts line.values.join(' | ')
            end
            puts "-" * len
        end
    end



    # op
  
    list_of_hashes = [
        {"name" => "Alaa Abdelnaby", "year_start" => 1991, "year_end" => 1995, "position" => "F-C", "height" => 6-10, "weight" => 240,
        "birth_date" => 1968, "college" => "Duke University"}]
    def load_csv_hash(db_name)
        # db_name = ('nba_player_data.csv')
        if(!File.exist?(db_name))
            puts 'File does not exist'
            return
        else
            list_of_hashes = CSV.open(db_name, headers: true).map(&:to_hash)
            return list_of_hashes
        end
    end


    list_of_hashes = [
        {"name" => "Alaa Abdelnaby", "year_start" => 1991, "year_end" => 1995, "position" => "F-C", "height" => 6-10, "weight" => 240,
        "birth_date" => 1968, "college" => "Duke University"}]    # result ->> name,birth_state,age
            #   Andre,CA,60
    def write_to_file(list_of_hashes, db_name)
        # db_name = ('nba_player_data.csv')
        CSV.open(db_name, "w", :headers => true) do |csv|
            if list_of_hashes.length == 0
                return
            end 
            csv << list_of_hashes[0].keys # how to fix this???
            list_of_hashes.each do |hash|
                csv << CSV::Row.new(hash.keys, hash.values)
            end
        end
    end

    list_of_hashes = [
        {"name" => "Alaa Abdelnaby", "year_start" => 1991, "year_end" => 1995, "position" => "F-C", "height" => 6-10, "weight" => 240,
        "birth_date" => 1968, "college" => "Duke University"}] 
    list_of_columns = ["name", "year_start", "year_end", "position", "height", "weight", "birth_date", "college"] 
    def get_columns(list_of_hashes, list_of_columns)
        if !list_of_hashes
            return
        else
            result = []
            list_of_hashes.each do |hash|
                new_hash = {}
                if list_of_columns[0] == "*"
                    result << hash
                else 
                    list_of_columns.each do |column|
                        new_hash[column] = hash[column]
                    end
                    result << new_hash
                end
            end
            return result
        end
    end

    list_of_hashes = [
        {"name" => "Alaa Abdelnaby", "year_start" => 1991, "year_end" => 1995, "position" => "F-C", "height" => 6-10, "weight" => 240,
        "birth_date" => 1968, "college" => "Duke University"}]    
    order_type = "asc" || "desc"
    column = "name"
    def order_op(list_of_hashes, order_type, column)
        0.upto list_of_hashes.length - 1 do |i|
            i.upto list_of_hashes.length - 1 do |j|
                line_i = list_of_hashes[i] # "name" => "iva", "age" => 5, "gender" => "F"}
                line_j = list_of_hashes[j] # {"name" => "tor", "age" => 2, "gender" => "M"}

                val_i = line_i[column] #  "age" => 5
                val_j = line_j[column] #  "age" => 2

                if order_type == "asc"
                    if val_i > val_j
                        temp = list_of_hashes[i]
                        list_of_hashes[i] = list_of_hashes[j]
                        list_of_hashes[j] = temp
                    end
                elsif order_type == "desc"
                    if val_i < val_j
                        temp = list_of_hashes[i]
                        list_of_hashes[i] = list_of_hashes[j]
                        list_of_hashes[j] = temp
                    end
                end
            end
        end
        return list_of_hashes
    end


    list_of_hashes = [
        {"name" => "Alaa Abdelnaby", "year_start" => 1991, "year_end" => 1995, "position" => "F-C", "height" => 6-10, "weight" => 240,
        "birth_date" => 1968, "college" => "Duke University"}] 
        new_hash = {'firstname' => "Thomas", 'lastname' => "Anderson", 'age' => 33, 'password' => 'matrix'}
        # list_of_hashes = [
        #     {"name" => "Cliff Barker", "year_start" => 1994, "year_end" => 1999, "position" => "F-C", "height" => 8-10, "weight" => 230,
        #     "birth_date" => 1978, "college" => "University of Kentucky"}] 
    def insert_op(list_of_hashes, new_hash)
        result = []
        list_of_hashes.each do |row|
            result.push(row)
        end
        result.push(new_hash)
        return result
    end

    list_of_hashes = [
        {"name" => "Alaa Abdelnaby", "year_start" => 1991, "year_end" => 1995, "position" => "F-C", "height" => 6-10, "weight" => 240,
        "birth_date" => 1968, "college" => "Duke University"}] 
    criteria_hash = {"name" => "Alaa Abdelnaby", "year_start" => 1991}
    # true or false
    def is_criteria_satisfied (line_from_list, criteria_hash)
        if criteria_hash == nil
            return true
        end
        criteria_hash.each do |key, value|
            if value != line_from_list[key]
                return false
            end 
        end
        return true
    end

    list_of_hashes = [
        {"name" => "Alaa Abdelnaby", "year_start" => 1991, "year_end" => 1995, "position" => "F-C", "height" => 6-10, "weight" => 240,
        "birth_date" => 1968, "college" => "Duke University"}] 
    update_hash = {"name" => "Alaa Abdelnaby", "year_start" => 2000}

    def my_merge(line_from_list, update_hash)
        update_hash.each do |key, value|
            line_from_list[key] = value
        end
        return line_from_list
    end

    list_of_hashes = [
        {"name" => "Alaa Abdelnaby", "year_start" => 1991, "year_end" => 1995, "position" => "F-C", "height" => 6-10, "weight" => 240,
        "birth_date" => 1968, "college" => "Duke University"}] 
    criteria_hash = {"name" => "Alaa Abdelnaby", "year_start" => 1991}
    update_hash = {"name" => "Alaa Abdelnaby", "year_start" => 1992, "year_end" => 1995}

    def update_op(list_of_hashes, criteria_hash, update_hash)
        result = []
        list_of_hashes.each do |row|
            if is_criteria_satisfied(row, criteria_hash)
                updated_row = my_merge(row, update_hash)
                result << updated_row
            else
                result << row
            end
        end
        return result
    end

    list_of_hashes = [
        {"name" => "Alaa Abdelnaby", "year_start" => 1991, "year_end" => 1995, "position" => "F-C", "height" => 6-10, "weight" => 240,
        "birth_date" => 1968, "college" => "Duke University"}] 
    criteria_hash = {"birth_date" => 1968}

    def where_op(list_of_hashes, criteria_hash)
        result = []
        list_of_hashes.each do |row|
            if is_criteria_satisfied(row, criteria_hash)
                result << row
            end
        end
        return result
    end

    list_of_hashes = [
        {"name" => "Alaa Abdelnaby", "year_start" => 1991, "year_end" => 1995, "position" => "F-C", "height" => 6-10, "weight" => 240,
        "birth_date" => 1968, "college" => "Duke University"}] 
    criteria_hash = {"birth_date" => 1968}

    def delete_op(list_of_hashes, criteria_hash)
        result = []
        if criteria_hash != nil
            list_of_hashes.each do |row|
                if is_criteria_satisfied(row, criteria_hash)
                    next
                else
                    result << row
                end
            end
        end
        return result
    end




    # run executes the request.
    def run
        if @table_name != nil
            parsed_csv = load_csv_hash(@table_name)
        else
            puts "Valid request contains table"
            return
        end
        if @request == 'select'
            if @join != nil
                parsed_csv = run_join
            end
            if @order_request != nil
                parsed_csv = order_op(parsed_csv, @order_request[:order], @order_request[:column_name])
            end
            if @where != nil
                parsed_csv = where_op(parsed_csv, {@where[:column]=> @where[:value]})
            end
            if @columns != nil && @table_name != nil
                result = get_columns(parsed_csv, @columns)
                print_selection(result)
            else
                puts "Provide columns to SELECT"
                return
            end
        end

        if @request == 'insert'
            if @data != nil
                parsed_csv = insert_op(parsed_csv, @data)
            end
            write_to_file(parsed_csv, @table_name)
        end

        if @request == 'update'
            if @where != nil
                @where = {@where[:column] => @where[:value]}
            end
            parsed_csv = update_op(parsed_csv, @where, @data)
            write_to_file(parsed_csv, @table_name)
        end

        if @request == 'delete'
            if @where != nil
                @where = {@where[:column]=> @where[:value]}
            end
            parsed_csv = delete_op(parsed_csv, @where)
            write_to_file(parsed_csv, @table_name)
        end

        
    end
end
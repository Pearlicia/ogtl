class MySqliteRequest
    attr_reader :table_name, :select_columns, :where_criteria, :join_table, :join_column_a, :join_column_b, :order_column, :order_direction, :insert_table_name, :insert_data, :update_table_name, :update_data, :delete_criteria
    
    def initialize
      @table_name = nil
      @select_columns = []
      @where_criteria = []
      @join_table = nil
      @join_column_a = nil
      @join_column_b = nil
      @order_column = nil
      @order_direction = nil
      @insert_table_name = nil
      @insert_data = []
      @update_table_name = nil
      @update_data = {}
      @delete_criteria = []
    end
    
    def from(table_name)
      @table_name = table_name
      self
    end
    
    def select(columns)
      if columns.is_a?(Array)
        @select_columns += columns
      else
        @select_columns << columns
      end
      self
    end
    
    def where(column_name, criteria)
      @where_criteria << { column_name: column_name, criteria: criteria }
      self
    end
    
    def join(column_on_db_a, filename_db_b, column_on_db_b)
      @join_table = CSV.read(filename_db_b, headers: true)
      @join_column_a = column_on_db_a
      @join_column_b = column_on_db_b
      self
    end
    
    def order(order, column_name)
      @order_column = column_name
      @order_direction = order
      self
    end
    
    def insert(table_name)
      @insert_table_name = table_name
      self
    end
    
    def values(data)
      @insert_data << data
      self
    end
    
    def update(table_name)
      @update_table_name = table_name
      self
    end
    
    def set(data)
      @update_data.merge!(data)
      self
    end
    
    def delete
      @delete_criteria << @where_criteria.last
      self
    end
    
    def run
      result = CSV.read(@table_name, headers: true)
      
      # filter by where criteria
      @where_criteria.each do |criteria|
        result = result.select { |row| row[criteria[:column_name]] == criteria[:criteria] }
      end
      
      # join tables if necessary
      if @join_table
        result = result.map do |row|
          join_row = @join_table.find { |j_row| j_row[@join_column_b] == row[@join_column_a] }
          row.to_h.merge(join_row.to_h)
        end
      end
      
      # select columns
      result = result.map do |row|
        row.select { |k, v| @select_columns.include?(k) || @select_columns.empty? }
      end
      
      # order
      if @order_column
        result = result.sort_by { |row| row[@order_column] }
        result = result.reverse if @order_direction == :desc
      end
      
      # insert data
      if @insert_table_name
        CSV.open(@insert_table_name, 'a+') do |csv|
          @insert_data.each do |data|
            row = CSV::Row.new([], [])
            data.each do |key, value|
              row[key] = value
            end
            csv << row
          end
        end
      end
      
      # update data
      if @update_table_name
        data_to_update = CSV
  
  
  require 'csv'
  
  class MySqliteRequest
      attr_reader :table_name, :select_columns, :where_criteria, :join_table, :join_column_a, :join_column_b, :order_column, :order_direction, :insert_table_name, :insert_data, :update_table_name, :update_data, :delete_criteria
      def initialize
          @table_name = nil
          @select_columns = []
          @where_criteria = []
          @join_table = nil
          @join_column_a = nil
          @join_column_b = nil
          @order_column = nil
          @order_direction = nil
          @insert_table_name = nil
          @insert_data = []
          @update_table_name = nil
          @update_data = {}
          @delete_criteria = []
        end  
  
  class MySqliteRequest
    attr_accessor :table_name, :select_columns, :where_conditions, :join_table, :join_on_column, :order_column, :order_direction, :insert_data, :update_table, :update_data, :delete_flag
  
    def initialize
      @select_columns = []
      @where_conditions = []
      @insert_data = {}
      @update_data = {}
      @delete_flag = false
    end
  
    def from(table_name)
      @table_name = table_name
      self
    end
  
    def select(column_name)
      @select_columns << column_name
      self
    end
  
    def where(column_name, criteria)
      @where_conditions << { column_name: column_name, criteria: criteria }
      self
    end
  
    def join(column_on_db_a, filename_db_b, column_on_db_b)
      @join_table = { filename: filename_db_b, column_a: column_on_db_a, column_b: column_on_db_b }
      self
    end
  
    def order(order, column_name)
      @order_column = column_name
      @order_direction = order
      self
    end
  
    def insert(table_name)
      @table_name = table_name
      self
    end
  
    def values(data)
      @insert_data = data
      self
    end
  
    def update(table_name)
      @table_name = table_name
      self
    end
  
    def set(data)
      @update_data = data
      self
    end
  
    def delete
      @delete_flag = true
      self
    end
  
    def run
      result = []
  
      if @insert_data.any?
        insert_row
        return
      end
  
      if @update_data.any?
        update_rows
        return
      end
  
      if @delete_flag
        delete_rows
        return
      end
  
      CSV.foreach(@table_name, headers: true) do |row|
        next unless valid_row?(row)
  
        result_row = {}
  
        @select_columns.each do |column|
          result_row[column] = row[column]
        end
  
        result << result_row
      end
  
      if @order_column
        result = order_result(result)
      end
  
      result
    end
  
    private
  
    def valid_row?(row)
      return false if @where_conditions.empty?
  
      @where_conditions.each do |condition|
        return false unless row[condition[:column_name]] == condition[:criteria]
      end
  
      true
    end
  
    def order_result(result)
      result.sort_by { |row| row[@order_column] }
  
      if @order_direction == :desc
        result.reverse!
      end
  
      result
    end
  
    def insert_row
      CSV.open(@table_name, "a+") do |csv|
        csv << @insert_data.values
      end
    end
  
    def update_rows
      rows = CSV.read(@table_name, headers: true)
      rows.each do |row|
        next unless valid_row?(row)
  
        @update_data.each do |key, value|
          row[key] = value
        end
      end
  
      File.write(@table_name, rows.to_csv, mode: "w")
    end
  
    def delete_rows
      rows = CSV.read(@table_name, headers: true)
      rows.delete_if { |row| valid_row?(row) }
      File.write(@table_name, rows.to_csv, mode: "w")
    end
  end
  
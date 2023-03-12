require 'csv'

class MySqliteRequest
  attr_accessor :table_name, :select_columns, :where_conditions, :join, :order_by, :insert_table_name, :insert_data, :update_table_name, :update_data, :delete_where_conditions

  def initialize
    @select_columns = []
    @where_conditions = []
    @insert_data = {}
    @update_data = {}
    @delete_where_conditions = []
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
    @where_conditions << [column_name, criteria]
    self
  end

  def join(column_on_db_a, filename_db_b, column_on_db_b)
    @join = [column_on_db_a, filename_db_b, column_on_db_b]
    self
  end

  def order(order, column_name)
    @order_by = [order, column_name]
    self
  end

  def insert(table_name)
    @insert_table_name = table_name
    self
  end

  def values(data)
    @insert_data = data
    self
  end

  def update(table_name)
    @update_table_name = table_name
    self
  end

  def set(data)
    @update_data = data
    self
  end

  def delete
    @delete_where_conditions = @where_conditions
    self
  end

  def run
    if @insert_table_name
      insert_data_into_table
    elsif @update_table_name
      update_table
    elsif @delete_where_conditions.any?
      delete_from_table
    else
      select_from_table
    end
  end

  private

  def select_from_table
    result = []

    CSV.foreach(@table_name, headers: true) do |row|
      next unless match_where_conditions?(row)

      result << select_columns_from_row(row)
    end

    result.sort! { |a, b| sort_rows(a, b) } if @order_by
    result
  end

  def insert_data_into_table
    CSV.open(@insert_table_name, "a+") do |csv|
      csv << @insert_data.values
    end
  end

  def update_table
    CSV.open(@update_table_name, "a+") do |csv|
      CSV.foreach(@update_table_name, headers: true) do |row|
        next unless match_where_conditions?(row)

        @update_data.each do |column_name, value|
          row[column_name] = value
        end

        csv << row
      end
    end
  end

  def delete_from_table
    temp_file = Tempfile.new("new_file")
    temp_file_path = temp_file.path

    CSV.open(temp_file_path, "a+") do |csv|
      CSV.foreach(@table_name, headers: true) do |row|
        next if match_delete_conditions?(row)

        csv << row
      end
    end

    FileUtils.mv(temp_file_path, @table_name)
  end

  def match_where_conditions?(row)
    @where_conditions.all? do |condition|
      column_name, criteria = condition
      row[column_name] == criteria
    end
  end

  def select_columns_from_row(row)
    if @select_columns.empty?
      row.to_h
    else
      row.to_h.select { |k, _| @select_columns.include?(k) }
    end
 
    def match_delete_conditions?(row)
        @delete_where_conditions.all? do |condition|
        column_name, criteria = condition
        row[column_name] == criteria
        end
        end
        
        def sort_rows(a, b)
        order, column_name = @order_by
        if order == "ASC"
        a[column_name] <=> b[column_name]
        else
        b[column_name] <=> a[column_name]
        end
        end
        end
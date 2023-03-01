require 'csv'

class MySqliteRequest
  def initialize
    @table_name = ''
    @select_columns = []
    @where_conditions = {}
    @join_conditions = {}
    @order_by = {}
    @insert_data = {}
    @update_table = ''
    @update_data = {}
    @delete_conditions = {}
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
    @where_conditions[column_name] = criteria
    self
  end

  def join(column_on_db_a, filename_db_b, column_on_db_b)
    @join_conditions[:column_on_db_a] = column_on_db_a
    @join_conditions[:filename_db_b] = filename_db_b
    @join_conditions[:column_on_db_b] = column_on_db_b
    self
  end

  def order(order, column_name)
    @order_by[:order] = order
    @order_by[:column_name] = column_name
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
    self
  end

  def run
    result = []
    case
    when @select_columns.any?
      result = select_query
    when @insert_data.any?
      result = insert_query
    when @update_data.any?
      result = update_query
    when @delete_conditions.any?
      result = delete_query
    end
    result
  end

  private

  def select_query
    data = CSV.read(@table_name, headers: true).map(&:to_h)
    data = filter_data(data, @where_conditions) unless @where_conditions.empty?
    data = join_data(data, @join_conditions) unless @join_conditions.empty?
    data = order_data(data, @order_by) unless @order_by.empty?
    data.map { |row| row.select { |k, _| @select_columns.include?(k) } }
  end

  def insert_query
    CSV.open(@table_name, 'a') do |csv|
      csv << @insert_data.values
    end
    []
  end

  def update_query
    data = CSV.read(@table_name, headers: true).map(&:to_h)
    data = filter_data(data, @where_conditions) unless @where_conditions.empty?
    data.each do |row|
      row.merge!(@update_data) unless @update_data.empty?
    end
    write_data(data)
    []
  end

  def delete_query
    data = CSV.read(@table_name, headers: true).map(&:to_h)
    data = filter_data(data, @delete_conditions) unless @delete_conditions.empty?
    write_data(data)
    []
  end

  def filter_data(data, conditions)
    data.select do |row|
      conditions.all? { |column_name, criteria| row[column_name] == criteria }
    end
  end

  def join_data(data, conditions)
    joined_data = CSV.read(conditions[:filename_db_b], headers: true).map(&:to_h)
    data.each do |row|

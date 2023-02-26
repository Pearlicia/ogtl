require 'csv'

class MySqliteRequest
  attr_reader :table_name, :columns, :conditions, :join, :order, :insert_values, :update_table, :update_values, :delete

  def initialize
    @table_name = ''
    @columns = []
    @conditions = {}
    @join = {}
    @order = {}
    @insert_values = {}
    @update_table = ''
    @update_values = {}
    @delete = false
  end

  def from(table_name)
    @table_name = table_name
    self
  end

  def select(*columns)
    @columns += columns
    self
  end

  def where(column_name, criteria)
    @conditions[column_name] = criteria
    self
  end

  def join(column_on_db_a, filename_db_b, column_on_db_b)
    @join = {
      column_on_db_a: column_on_db_a,
      filename_db_b: filename_db_b,
      column_on_db_b: column_on_db_b
    }
    self
  end

  def order(order, column_name)
    @order = {
      order: order,
      column_name: column_name
    }
    self
  end

  def insert(table_name)
    @table_name = table_name
    self
  end

  def values(data)
    @insert_values = data
    self
  end

  def update(table_name)
    @update_table = table_name
    self
  end

  def set(data)
    @update_values = data
    self
  end

  def delete
    @delete = true
    self
  end

  def run
    if @insert_values.any?
      insert_data
    elsif @update_values.any?
      update_data
    elsif @delete
      delete_data
    else
      select_data
    end
  end

  private

  def select_data
    data = CSV.read(@table_name, headers: true, header_converters: :symbol)
    data = apply_join(data) if @join.any?
    data = apply_where(data) if @conditions.any?
    data = apply_order(data) if @order.any?
    data.map { |row| select_columns(row.to_h) }
  end

  def insert_data
    CSV.open(@table_name, 'a', write_headers: true, headers: @insert_values.keys) do |csv|
      csv << @insert_values.values
    end
  end

  def update_data
    data = CSV.read(@update_table, headers: true, header_converters: :symbol)
    data = apply_where(data) if @conditions.any?
    data.each do |row|
      row_hash = row.to_h
      @update_values.each { |key, value| row_hash[key.to_sym] = value }
      row.replace(row_hash)
    end
    CSV.open(@update_table, 'w', write_headers: true, headers: data.headers) do |csv|
      csv << data.headers
      data.each { |row| csv << row }
    end
  end

  def delete_data
    data = CSV.read(@table_name, headers: true, header_converters: :symbol)
    data = apply_where(data) if @conditions.any?
    CSV.open(@table_name, 'w', write_headers: true, headers: data.headers) do |csv|
      csv << data.headers
      data.each { |row| csv << row } unless @delete
    end
  end
end


require 'sqlite3'
require 'json'
require 'sinatra'
require 'securerandom'

class User
  def initialize
    @db = SQLite3::Database.new 'db.sql'
    create_table
  end

  def create_table
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstname TEXT,
        lastname TEXT,
        age INTEGER,
        password TEXT,
        email TEXT
      );
    SQL
  end

  def create(user_info)
    firstname = user_info['firstname']
    lastname = user_info['lastname']
    age = user_info['age']
    password = user_info['password']
    email = user_info['email']

    @db.execute("INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?);", [firstname, lastname, age, password, email])
    id = @db.last_insert_row_id
    return id
  end

  def find(user_id)
    query = "SELECT * FROM users WHERE id = ?"
    result = @db.execute(query, user_id).first
    { id: result[0], firstname: result[1], lastname: result[2], age: result[3], email: result[5] }
  end

  def all
    query = "SELECT * FROM users"
    users = {}
    @db.execute(query).each do |result|
      users[result[0]] = { id: result[0], firstname: result[1], lastname: result[2], age: result[3], email: result[5] }
    end
    users
  end

  def update(user_id, attribute, value)
    query = "UPDATE users SET #{attribute} = ? WHERE id = ?"
    @db.execute(query, value, user_id)
    find(user_id)
  end

  def destroy(user_id)
    query = "DELETE FROM users WHERE id = ?"
    @db.execute(query, user_id)
  end
end

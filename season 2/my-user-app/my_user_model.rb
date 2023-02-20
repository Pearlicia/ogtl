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


# require 'sqlite3'

# class User
#     def initialize
#     @db = SQLite3::Database.new 'db.sql'
#     create_table
#   end

#   def create_table
#     @db.execute <<-SQL
#       CREATE TABLE IF NOT EXISTS users (
#         id INTEGER PRIMARY KEY AUTOINCREMENT,
#         firstname TEXT,
#         lastname TEXT,
#         age INTEGER,
#         password TEXT,
#         email TEXT
#       );
#     SQL
#   end

#   DB_FILE = 'db.sql'

#   def self.create(user_info)
#     db = SQLite3::Database.new(DB_FILE)
#     db.execute('INSERT INTO users(firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)',
#                [user_info['firstname'], user_info['lastname'], user_info['age'], user_info['password'], user_info['email']])
#     db.last_insert_row_id
#   end

#   def self.find(user_id)
#     db = SQLite3::Database.new(DB_FILE)
#     db.results_as_hash = true
#     db.execute('SELECT * FROM users WHERE id = ?', [user_id]).first
#   end

#   def self.all
#     db = SQLite3::Database.new(DB_FILE)
#     db.results_as_hash = true
#     db.execute('SELECT id, firstname, lastname, age, email FROM users').map { |row| row.reject { |k, _| k == 'password' } }
#   end

#   def self.update(user_id, attribute, value)
#     db = SQLite3::Database.new(DB_FILE)
#     db.execute("UPDATE users SET #{attribute} = ? WHERE id = ?", [value, user_id])
#   end

#   def self.destroy(user_id)
#     db = SQLite3::Database.new(DB_FILE)
#     db.execute('DELETE FROM users WHERE id = ?', [user_id])
#   end

#   def self.authenticate(email, password)
#     db = SQLite3::Database.new(DB_FILE)
#     db.results_as_hash = true
#     db.execute('SELECT * FROM users WHERE email = ? AND password = ?', [email, password]).first
#   end
# end



# New one

require 'sqlite3'

class User
  def initialize
    @db = SQLite3::Database.new('db.sql')
    create_table
  end

  def create_table
    query = <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        firstname TEXT,
        lastname TEXT,
        age INTEGER,
        password TEXT,
        email TEXT
      );
    SQL

    @db.execute(query)
  end

  def create(user_info)
    query = <<-SQL
      INSERT INTO users (firstname, lastname, age, password, email)
      VALUES (?, ?, ?, ?, ?)
    SQL

    @db.execute(query, user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:password], user_info[:email])

    # return the id of the created user
    @db.last_insert_row_id
  end

  def find(user_id)
    query = <<-SQL
      SELECT * FROM users WHERE id = ?
    SQL

    user_data = @db.execute(query, user_id).first
    {
      id: user_data[0],
      firstname: user_data[1],
      lastname: user_data[2],
      age: user_data[3],
      email: user_data[5]
    }
  end

  def all
    query = <<-SQL
      SELECT id, firstname, lastname, age, email FROM users
    SQL

    users_data = @db.execute(query)
    users_data.map do |user_data|
      {
        id: user_data[0],
        firstname: user_data[1],
        lastname: user_data[2],
        age: user_data[3],
        email: user_data[4]
      }
    end
  end

  def update(user_id, attribute, value)
    query = <<-SQL
      UPDATE users SET #{attribute} = ? WHERE id = ?
    SQL

    @db.execute(query, value, user_id)
    find(user_id)
  end

  def destroy(user_id)
    query = <<-SQL
      DELETE FROM users WHERE id = ?
    SQL

    @db.execute(query, user_id)
  end
end

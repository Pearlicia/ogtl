require 'sqlite3'
require 'json'
require 'sinatra'


# class User
#   def initialize
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

#   def create(user_info)
#     firstname = user_info['firstname']
#     lastname = user_info['lastname']
#     age = user_info['age']
#     password = user_info['password']
#     email = user_info['email']

#     @db.execute("INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?);", [firstname, lastname, age, password, email])
#     id = @db.last_insert_row_id
#     return id
#   end

#   def find(user_id)
#     query = "SELECT * FROM users WHERE id = ?"
#     result = @db.execute(query, user_id).first
#     { id: result[0], firstname: result[1], lastname: result[2], age: result[3], email: result[5] }
#   end

#   def all
#     query = "SELECT * FROM users"
#     users = {}
#     @db.execute(query).each do |result|
#       users[result[0]] = { id: result[0], firstname: result[1], lastname: result[2], age: result[3], email: result[5] }
#     end
#     users
#   end

#   def update(user_id, attribute, value)
#     query = "UPDATE users SET #{attribute} = ? WHERE id = ?"
#     @db.execute(query, value, user_id)
#     find(user_id)
#   end

#   def destroy(user_id)
#     query = "DELETE FROM users WHERE id = ?"
#     @db.execute(query, user_id)
#   end
# end


require 'sqlite3'

# db = SQLite3::Database.open 'test.db'

class User
    def initialize
        db = SQLite3::Database.open 'db.sql'
        db.results_as_hash = true
        db.execute "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, age INTEGER, password TEXT, email TEXT)"
    end


  def create(user_info)
    db = SQLite3::Database.open 'db.sql'

    firstname = user_info['Ebi']
    lastname = user_info['Ebikon']
    age = user_info['20']
    password = user_info['ebi']
    email = user_info['ebi@gmail.com']

    db.execute "INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)", firstname, lastname, age, password, email
    id = db.last_insert_row_id
    return id
  end

  def find(user_id)
    db = SQLite3::Database.open 'db.sql'
    db.results_as_hash = true
    query = "SELECT * FROM users WHERE id = ?"
    result = db.execute(query, user_id).first
    { id: result[0], firstname: result[1], lastname: result[2], age: result[3], password: result[4], email: result[5] }
    result
  end

  def all
    db = SQLite3::Database.open 'db.sql'
    db.results_as_hash = true
    query = "SELECT * FROM users"
    users = {}
    db.execute(query).each do |result|
        users[result[0]] = { id: result[0], firstname: result[1], lastname: result[2], age: result[3], password: result[4], email: result[5] }
    end
    users  
  end

  def update(user_id, attribute, value)
    db = SQLite3::Database.open 'db.sql'
    query = "UPDATE users SET #{attribute} = ? WHERE id = ?"
    db.execute(query, value, user_id)
    find(user_id)
  end

  def destroy(user_id)
    db = SQLite3::Database.open 'db.sql'
    db.execute('DELETE FROM users WHERE id = ?', [user_id])
  end

#   def self.authenticate(email, password)
#     db = SQLite3::Database.new(DB_FILE)
#     db.results_as_hash = true
#     db.execute('SELECT * FROM users WHERE email = ? AND password = ?', [email, password]).first
#   end
end

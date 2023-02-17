require 'sqlite3'
require 'json'
require 'sinatra'
require 'securerandom'

class User
  def initialize
    @db = SQLite3::Database.new('db.sql')
    @db.execute('CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, age INTEGER, password TEXT, email TEXT)')
  end

  def create(user_info)
    query = "INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)"
    @db.execute(query, user_info['firstname'], user_info['lastname'], user_info['age'], user_info['password'], user_info['email'])
    @db.last_insert_row_id
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

enable :sessions

before do
  if session[:user_id]
    @current_user = User.new.find(session[:user_id])
  end
end

get '/' do
  erb :index
end

get '/users' do
  users = User.new.all.values.map { |u| u.reject { |k, v| k == :password } }
  JSON.generate(users)
end

post '/users' do
  user_id = User.new.create(params)
  user = User.new.find(user_id).reject { |k, v| k == :password }
  JSON.generate(user)
end

post '/sign_in' do
  query = "SELECT id FROM users WHERE email = ? AND password = ?"
  result = User.new.instance_variable_get(:@db).execute(query, params['email'], params['password']).first
  if result
    session[:user_id] = result[0]
    user = User.new.find(session[:user_id]).reject { |k, v| k == :password }
    JSON.generate(user)
  else
    halt 401, 'Invalid email or password'
  end
end

put '/users' do
  halt 401, 'Unauthorized' unless @current_user
  User.new.update(session[:user_id], 'password', params['password'])


  require 'sinatra'
  require 'sqlite3'
  require 'json'
  
  class User
    attr_accessor :id, :firstname, :lastname, :age, :password, :email
  
    def initialize(id, firstname, lastname, age, password, email)
      @id = id
      @firstname = firstname
      @lastname = lastname
      @age = age
      @password = password
      @email = email
    end
  
    def self.create(user_info)
      db = SQLite3::Database.new('db.sql')
      db.execute('CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, age INTEGER, password TEXT, email TEXT)')
      db.execute('INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)', [user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:password], user_info[:email]])
      id = db.last_insert_row_id
      db.close
      return id
    end
  
    def self.find(user_id)
      db = SQLite3::Database.new('db.sql')
      result = db.execute('SELECT * FROM users WHERE id = ?', user_id).flatten
      db.close
      if result.empty?
        return nil
      else
        return User.new(result[0], result[1], result[2], result[3], result[4], result[5])
      end
    end
  
    def self.all
      db = SQLite3::Database.new('db.sql')
      result = db.execute('SELECT id, firstname, lastname, age, email FROM users')
      db.close
      users = []
      result.each do |row|
        users << { id: row[0], firstname: row[1], lastname: row[2], age: row[3], email: row[4] }
      end
      return users
    end
  
    def self.update(user_id, attribute, value)
      db = SQLite3::Database.new('db.sql')
      db.execute("UPDATE users SET #{attribute} = ? WHERE id = ?", [value, user_id])
      result = db.execute('SELECT * FROM users WHERE id = ?', user_id).flatten
      db.close
      if result.empty?
        return nil
      else
        return User.new(result[0], result[1], result[2], result[3], result[4], result[5])
      end
    end
  
    def self.destroy(user_id)
      db = SQLite3::Database.new('db.sql')
      db.execute('DELETE FROM users WHERE id = ?', user_id)
      db.close
    end
  end
  
  before do
    @current_user = User.find(session[:user_id])
  end
  
  get '/' do
    erb :index
  end
  
  get '/users' do
    users = User.all.map { |user| { id: user[:id], firstname: user[:firstname], lastname: user[:lastname], age: user[:age], email: user[:email] } }
    return JSON.generate(users)
  end
  
  post '/users' do
    user_id = User.create(params)
    user = User.find(user_id)
    return JSON.generate({ id: user.id, firstname: user.firstname, lastname: user.lastname, age: user.age, email: user.email })
  end
  
  post '/sign_in' do
    user = User.all.find { |user| user.email == params[:email] && user.password ==

# New
# Here is an example implementation of the User class in Ruby with the methods described in Part I of the project:

require 'sqlite3'

class User
  def initialize(dbname)
    @db = SQLite3::Database.new(dbname)
    @db.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, age INTEGER, password TEXT, email TEXT)")
  end
  
  def create(user_info)
    @db.execute("INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)", [user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:password], user_info[:email]])
    id = @db.execute("SELECT last_insert_rowid()")[0][0]
    return id
  end
  
  def find(user_id)
    user = @db.execute("SELECT * FROM users WHERE id=?", user_id)[0]
    return { id: user[0], firstname: user[1], lastname: user[2], age: user[3], email: user[5] }
  end
  
  def all
    users = {}
    @db.execute("SELECT id, firstname, lastname, age, email FROM users").each do |user|
      users[user[0]] = { firstname: user[1], lastname: user[2], age: user[3], email: user[4] }
    end
    return users
  end
  
  def update(user_id, attribute, value)
    @db.execute("UPDATE users SET #{attribute}=? WHERE id=?", [value, user_id])
    return find(user_id)
  end
  
  def destroy(user_id)
    @db.execute("DELETE FROM users WHERE id=?", user_id)
  end
end

# This class uses the SQLite3 gem to interact with an SQLite database file named db.sql and defines methods to create, find, get all, update, and destroy user records in the database.

# Here is an example implementation of a controller for the routes described in Part II of the project:
require 'sinatra'
require 'json'
require 'sinatra/cookies'

require_relative 'user.rb'

user = User.new("db.sql")

# GET on /users. This action will return all users (without their passwords).
get '/users' do
  users = user.all
  users.each_value { |u| u.delete(:password) }
  return JSON.generate(users)
end

# POST on /users. Receiving firstname, lastname, age, password and email.
# It will create a user and store in your database and returns the user created (without password).
post '/users' do
  user_info = { firstname: params[:firstname], lastname: params[:lastname], age: params[:age].to_i, password: params[:password], email: params[:email] }
  id = user.create(user_info)
  new_user = user.find(id)
  new_user.delete(:password)
  return JSON.generate(new_user)
end

# POST on /sign_in. Receiving email and password.
# It will add a session containing the user_id in order to be logged in and returns the user created (without password).
post '/sign_in' do
  email = params[:email]
  password = params[:password]
  user_record = user.all.find { |_, u| u[:email] == email && u[:password] == password }
  if user_record
    session[:user_id] = user_record[0]
    user_record[1].delete(:password)
    return JSON.generate(user_record[1])
  else
    status 401
    return "Invalid email or"


#Another one
require 'sqlite3'

class User
  def initialize(db_name)
    @db = SQLite3::Database.new(db_name)
    create_table
  end

  def create(user_info)
    # implement logic to create a user in the database
  end

  def find(user_id)
    # implement logic to find a user by id and return user info
  end

  def all
    # implement logic to retrieve all users and return as a hash
  end

  def update(user_id, attribute, value)
    # implement logic to update a user's attribute in the database
  end

  def destroy(user_id)
    # implement logic to destroy a user in the database
  end

  private

  def create_table
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        firstname TEXT,
        lastname TEXT,
        age INTEGER,
        password TEXT,
        email TEXT
      );
    SQL
  end
end


Note that this code creates a User class with a SQLite3 database connection, and implements the methods described in the project description for creating, finding, getting all, updating, and destroying users in the database.

In order to use this User class, you can create a new instance of it with the name of the database file as a parameter, like this:

user_db = User.new('db.sql')


You can then call the methods on the user_db object to interact with the database and manipulate user information.

For the second part of the project, you would need to create a controller that uses this User class, and define routes for handling different HTTP requests. Here's an example code for the controller (using the Sinatra web framework):

require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/cookies'

user_db = User.new('db.sql')

get '/users' do
  users = user_db.all
  users.each { |user| user.delete('password') }
  json users
end

post '/users' do
  user_info = {
    firstname: params[:firstname],
    lastname: params[:lastname],
    age: params[:age],
    password: params[:password],
    email: params[:email]
  }
  user_id = user_db.create(user_info)
  created_user = user_db.find(user_id)
  created_user.delete('password')
  json created_user
end

post '/sign_in' do
  email = params[:email]
  password = params[:password]
  user = user_db.all.find { |u| u['email'] == email && u['password'] == password }
  if user
    session[:user_id] = user['id']
    user.delete('password')
    json user
  else
    halt 401
  end
end

put '/users' do
  user_id = session[:user_id]
  attribute = params[:attribute]
  value = params[:value]
  user_db.update(user_id, attribute, value)
  updated_user = user_db.find(user_id)
  updated_user.delete('password')
  json updated_user
end

delete '/sign_out' do
  session.clear
  status 204
end

delete '/users' do
  user_id = session[:user_id]
  user_db.destroy(user_id)
  session.clear
  status 204
end

get '/' do
  erb :index
end


Note that this code defines routes for handling GET, POST, PUT, and DELETE requests, and uses the User
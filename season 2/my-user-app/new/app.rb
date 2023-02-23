# require 'sqlite3'
# require 'json'
# require 'sinatra'
# require 'erb'
# require 'webrick'

# require './my_user_model.rb'

# set('views', './views')

# user_db = User.new('db.sql')

# enable :sessions

# before do
#   if session[:user_id]
#     @current_user = User.new.find(session[:user_id])
#   end
# end

# get '/' do
#   erb :index
# end


# get '/users' do
#   users = user_db.all
#   users.each { |user| user.delete('password') }
#   json users
#   erb :users
# end

# post '/users' do
#     user_info = {
#       firstname: params[:firstname],
#       lastname: params[:lastname],
#       age: params[:age],
#       password: params[:password],
#       email: params[:email]
#     }
#     user_id = user_db.create(user_info)
#     created_user = user_db.find(user_id)
#     created_user.delete('password')
#     json created_user
# end


# post '/sign_in' do
#   email = params[:email]
#   password = params[:password]
#   user = user_db.all.find { |u| u['email'] == email && u['password'] == password }
#   if user
#     session[:user_id] = user['id']
#     user.delete('password')
#     json user
#   else
#     halt 401, 'Invalid email or password'
#   end
# end

# put '/users' do
#   user_id = session[:user_id]
#   attribute = params[:attribute]
#   value = params[:value]
#   user_db.update(user_id, attribute, value)
#   updated_user = user_db.find(user_id)
#   updated_user.delete('password')
#   json updated_user
# end

# delete '/sign_out' do
#   session.clear
#   status 204
# end

# delete '/users' do
#   user_id = session[:user_id]
#   user_db.destroy(user_id)
#   session.clear
#   status 204
# end



# server = WEBrick::HTTPServer.new(
#   :BindAddress => "0.0.0.0",
#   :Port => 8080
# )

# # Define a handler to respond to incoming requests
# server.mount_proc '/' do |req, res|
#   res.body = "Hello, world!"
# end

# # Start the server
# server.start

# set :port, 8080
# run Sinatra::Application


require 'sinatra'
require 'sqlite3'
require './my_user_model'
require 'json'

# set :database, "sqlite3:db.sql"


enable :sessions

set :bind, '0.0.0.0'
set :port, 8080

set :public_folder, File.dirname(__FILE__) + '/views'

# set the database file name and create the table if it doesn't exist
# DB_FILE = 'db.sql'
# db = SQLite3::Database.new(DB_FILE)
# db.execute('CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, age INTEGER, password TEXT, email TEXT)')

# set the views directory
set('views', './views')

# GET route for /

get '/' do
	@users = User.all
	erb :index
end

# GET route for /users
get '/users' do
  User.all.to_json
end


# POST route for /users
post '/users' do
  id = User.create(params).to_i
  User.find(id).to_json
end

# POST route for /sign_in
post '/sign_in' do
  user = User.authenticate(params['email'], params['password'])
  session[:user_id] = user['id'] if user
  user.to_json
end

# PUT route for /users
put '/users' do
  User.update(session[:user_id], 'password', params['password'])
  User.find(session[:user_id]).to_json
end

# DELETE route for /sign_out
delete '/sign_out' do
  session.clear
  status 204
end

# DELETE route for /users
delete '/users' do
  User.destroy(session[:user_id])
  session.clear
  status 204
end

require 'sinatra'
require 'sqlite3'
require './my_user_model'
require 'json'


enable :sessions

set :bind, '0.0.0.0'
set :port, 8080

set :public_folder, File.dirname(__FILE__) + '/views'

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

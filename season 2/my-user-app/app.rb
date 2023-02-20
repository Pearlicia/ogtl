require 'sqlite3'
require 'json'
require 'sinatra'
require 'securerandom'
require 'sinatra/cookies'
require 'sinatra/json'
require 'sinatra/reloader'

require_relative 'my_user_model.rb'

user_db = User.new('db.sql')

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
    halt 401, 'Invalid email or password'
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

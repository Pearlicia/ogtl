require 'sinatra'
require 'json'
require_relative './my_user_model.rb'

set :bind, '0.0.0.0'
set :port, 8080
enable :sessions

get '/' do
	 @users = User.all
	erb :operations
end

get '/users' do
	status 200
	user = User.all.map{|attribute|attribute.slice("firstname", "lastname", "age", "email")}
	user.to_json
	erb :
end


post'/users'do
if params[:firstname] != nil
	new_user=User.create(params)
	find_user =User.find(new_user.id)
	user= {
		"firstname" => find_user.firstname, 
		"lastname"=> find_user.lastname,
		"age" => find_user.age,
		"email"=> find_user.email
	}.to_json	
else
	find_user=User.auth(params[:password],params[:email])
	if !find_user[0].empty?
		status 200
		session[:id]=find_user[0]["id"]
	else
		status 401
	end
	find_user[0].to_json
end

end

post'/sign_in'do
	auth_user = User.auth(params[:password], params[:email])
	if !auth_user.empty?
		status 200
		session[:id] = auth_user[0]["id"]
	else
		status 401
	end
	auth_user[0].to_json
end

put'/users'do
	User.update(session[:id],'password',params[:password])
	found_user = User.find(session[:id])
	status 200
	user_details = {
		"firstname" => found_user.firstname, 
		"lastname"=> found_user.lastname,
		"age" => found_user.age, 
		"email"=> found_user.email
	}.to_json
end

delete'/sign_out'do
	if session[:id]
	session[:id]= nil 
	end
	status 204
end

# uncomment line 76-78 to delete user. gandalf blocks deleting user from db
delete'/users'do
	if !session[:id].empty?
	 User.destroy(session[:id]) 
	end
		status 204
end
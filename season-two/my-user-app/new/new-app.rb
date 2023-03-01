require 'sinatra'
require 'sqlite3'
require './my_user_model'
require 'json'

enable :sessions

set :bind, '0.0.0.0'
set :port, 8080

set :public_folder, File.dirname(__FILE__) + '/views'

set('views', './views')


# GET route for /

get '/' do
	@users = User.all
	erb :index
end

get '/sign_in' do 
	erb :sign_in 
end


# GET route for /users
get '/users' do
    status 200
	@users = User.all.map{|attribute|attribute.slice("firstname", "lastname", "age", "email")}
	erb :index
end

# POST route for /users

post '/users' do
    if params[:firstname] != nil
        create_user = User.create(params)
        result = User.find(create_user.id)
        user_info = {
            "firstname" => result.firstname, 
            "lastname"=> result.lastname,
            "age" => result.age,
            "email"=> result.email
        }.to_json	

	
    else
        result = User.authenticate(params[:password],params[:email])
        if !result[0].empty?
            status 200
            session[:id]=result[0]["id"]
        else
            status 401
        end
        result[0].to_json
    end
        redirect '/'
end


# POST route for /sign_in
post '/sign_in' do
    user = User.authenticate(params[:password], params[:email])
	if !user.empty?
		status 200
		session[:id] = user[0]["id"]
		redirect '/users'
	else
		status 401
	end
	user[0].to_json
end

# PUT route for /users
put '/users' do
    User.update(session[:id],'password',params[:password])
	user = User.find(session[:id])
	status 200
	user_info = {
		"firstname" => user.firstname, 
		"lastname"=> user.lastname,
		"age" => user.age, 
		"email"=> user.email
	}.to_json
end


# DELETE route for /sign_out
delete '/sign_out' do
    if session[:id]
        session[:id]= nil 
    end
    status 204
end

# DELETE route for /users
delete '/users' do
    if !session[:id].empty?
        User.destroy(session[:id]) 
    end
    status 204
end

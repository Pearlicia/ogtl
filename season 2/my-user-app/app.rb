require 'sinatra'
require 'json'
require_relative './my_user_model.rb'

set :bind, '0.0.0.0'
set :port, 8080
enable :sessions


get '/sign_in' do 

end

get '/' do
	 @users = User.all
	erb :index
end

get '/users' do
	status 200
	@users = User.all.map{|attribute|attribute.slice("firstname", "lastname", "age", "email")}.to_json
	
end



post '/users' do
    if params[:firstname] != nil
        create_user = User.create(params)
        result = User.find(create_user.id)
        user = {
            "firstname" => result.firstname, 
            "lastname"=> result.lastname,
            "age" => result.age,
            "email"=> result.email
        }.to_json	

        
    else
        result = User.authenticate(params[:password], params[:email])
        if !result[0].empty?
            status 200
            session[:id] = result[0]["id"]
        else
            status 401
        end
        result[0].to_json
    end
	
end

post '/sign_in' do
	signin = User.authenticate(params[:password], params[:email])
	if !signin.empty?
		status 200
		session[:id] = signin[0]["id"]
		redirect '/users'
	else
		status 401
	end
	signin[0].to_json
end

put '/users' do
	User.update(session[:id],'password',params[:password])
	result = User.find(session[:id])
	status 200
	user_params = {
		"firstname" => result.firstname, 
		"lastname"=> result.lastname,
		"age" => result.age, 
		"email"=> result.email
	}.to_json
end

delete '/sign_out' do
	if session[:id]
	    session[:id]= nil 
	end
	status 204
end

delete '/users' do

	status 204
end
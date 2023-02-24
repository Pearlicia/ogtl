require 'sqlite3'
require 'json'
require 'sinatra'

class User < Sinatra::Base
    attr_accessor :id, :firstname, :lastname, :age, :password, :email
    def initialize (id=0, firstname, lastname, age, password, email)
        @firstname=firstname
        @lastname=lastname
        @age=age
        @email=email
        @password=password
        @id=id
    end
    def self.connection()
        begin
        @db = SQLite3::Database.open 'db.sql'
        @db = SQLite3::Database.new 'db.sql' 
        @db.results_as_hash = true
        
        @db.execute "CREATE TABLE IF NOT EXISTS users(id integer primary key, firstname string, lastname string, age integer, password string, email string)"
        return @db
        rescue SQLite3::Exception => error
            puts "Encountered an error"
            puts error
        end
    end
        
    def self.create(user_info)
        @db = self.connection

        firstname = user_info[:firstname]
        lastname = user_info[:lastname]
        age = user_info[:age]
        password = user_info[:password]
        email = user_info[:email]

        @db.execute "INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)", firstname, lastname, age, password, email
        user = User.new(user_info[:firstname], user_info[:lastname], user_info[:age], '', user_info[:email])

        user.id = @db.last_insert_row_id
        @db.close
        return user
    end

    def self.find(user_id)
        i = 0
        @db = self.connection
        @db.results_as_hash = true
        query = "SELECT * FROM users WHERE id = ?"
        result = @db.execute(query, user_id)
        first_user = User.new(result[i]['firstname'], result[i]['lastname'], result[i]['age'], result[i]['password'], result[i]['email'])
        return first_user
    end


    def self.all
        @db = self.connection
        @db.results_as_hash = true
        all_users = @db.execute "SELECT *FROM users"
        @db.close
        return all_users  
    end

    def self.update(user_id, attribute, value)
        @db = self.connection

        query = "UPDATE users SET #{attribute} = ? WHERE id = ?"
        @db.execute(query, value, user_id)
        edit_user_info = @db.execute "SELECT * FROM users where id  =?", user_id
        @db.close
        return edit_user_info   
    end

    def self.destroy(user_id)
        @db = self.connection
        delete_user_info = @db.execute "DELETE FROM users WHERE id=#{user_id}"
        @db.close
        return delete_user_info
    end

    def self.authenticate(email, password)
        @db = self.connection
        db.results_as_hash = true
        auth_user = @db.execute "SELECT * FROM users WHERE email =? AND password =?", email, password
        @db.close
        return auth_user      
    end
end

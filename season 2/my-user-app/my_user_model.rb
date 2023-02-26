require 'sqlite3'

 class User
    attr_accessor :id, :firstname, :lastname, :age, :password, :email

    def initialize (id=0, firstname, lastname, age, password, email)
        @firstname=firstname
        @lastname=lastname
        @age=age
        @email=email
        @password=password
        @id=id
    end

    def self.config()
        begin
        @db = SQLite3::Database.open 'db.sql'
        @db = SQLite3::Database.new 'db.sql' 
        @db.results_as_hash = true
      
        @db.execute "CREATE TABLE IF NOT EXISTS users( id integer primary key, firstname string, lastname string, age integer, password string, email string)"
        
        return @db

        rescue SQLite3::Exception => error
            puts "Encountered an error, #{error}"
        end
    end

    def self.create(user_info)
        @db = self.config
        @db.execute "INSERT INTO users(firstname, lastname, age, password, email) VALUES(?,?,?,?,?)", user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:password], user_info[:email]
        
        user = User.new(user_info[:firstname], user_info[:lastname], user_info[:age], '', user_info[:email])
        user.id = @db.last_insert_row_id
        @db.close
        return user
    end

    def self.find(user_id)
        i=0
        @db = self.config
        result = @db.execute "SELECT * FROM users WHERE id =?", user_id
        user_details=User.new(result[i]['firstname'], result[i]['lastname'], result[i]['age'], result[i]['password'], result[i]['email'])
        @db.close
        return user_details
    end

    def self.all
        @db = self.config
        all_users = @db.execute "SELECT *FROM users"
        @db.close
        return all_users
    end


    def self.update(user_id, attribute, value)
        @db = self.config
        @db.execute "UPDATE users SET #{attribute}= ? WHERE id =?",value ,user_id
        result = @db.execute "SELECT * FROM users where id  =?", user_id
        @db.close
        return result
    end

    def self.destroy(user_id)
        @db = self.config
        delete_user = @db.execute "DELETE FROM users WHERE id=#{user_id}"
        @db.close
        return delete_user
    end

    def self.authenticate(password, email)
        @db = self.config
        auth_user = @db.execute "SELECT * FROM users WHERE email =? AND password =?", email, password
        @db.close
        return auth_user
    end
 end
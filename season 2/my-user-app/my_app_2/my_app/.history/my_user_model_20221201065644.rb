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

    def self.connection()
        begin
        @db = SQLite3::Database.open 'db.sql'
        @db = SQLite3::Database.new 'db.sql' if !@db
        @db.results_as_hash = true
        #create table
        @db.execute "CREATE TABLE IF NOT EXISTS users
        (   id integer primary key,
            firstname string,
            lastname string,
            age integer, 
            password string,
            email string)"
        return @db
        rescue SQLite3::Exception => e
            puts "Error"
            puts e 
        end
    end

    def self.create(user_info)
        @db = self.connection
        @db.execute "INSERT INTO users(firstname, lastname, age, password, email) VALUES(?,?,?,?,?)", user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:password], user_info[:email]
        
        users=User.new(user_info[:firstname], user_info[:lastname], user_info[:age], '', user_info[:email])
        user.id = @db.last_insert_row_id
        @db.close
        return newuser
    end

    def self.find(user_id)
        i=0
        @db = self.connection
        user = @db.execute "SELECT * FROM users WHERE id =?", user_id
        user_info=User.new(user[i]['firstname'],user[i]['lastname'],user[i]['age'],user[i]['password'],user[i]['email'])
        @db.close
        return user_info
    end

    def self.all()
        @db = self.connection
        user = @db.execute "SELECT *FROM users"
        @db.close
        return user
    end

    def self.update(user_id, attribute, value)
        @db = self.connection
        @db.execute "UPDATE users SET #{attribute}= ? WHERE id =?",value ,user_id
        user = @db.execute "SELECT * FROM users where id  =?", user_id
        @db.close
        return user
    end

    def self.destroy(user_id)
        @db = self.connection
        deleted_user = @db.execute "DELETE FROM users WHERE id=#{user_id}"
        @db.close
        return deleted_user
    end

    def self.auth(password, email)
        @db = self.connection
        user = @db.execute "SELECT * FROM users WHERE email =? AND password =?", email, password
        @db.close
        return user
    end
 end
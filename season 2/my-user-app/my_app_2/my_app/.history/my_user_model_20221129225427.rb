require 'sqlite3'
 class User
    attr_accessor :id, :firstname, :lastname, :age, :password, :email
    # def initialize (id=0, firstname, lastname, age, password, email)
        
    # end

    def self.connection
        @db = SQLite3::Database.open 'db.sql'
        @db = SQLite3::Database.new 'db.sql' if !@db
        @db.results_as_hash = true
        #create table
        @db.execute "CREATE TABLE IF NOT EXISTS users
        (
            id integer primary key,
            firstname VARCHAR(200),
            lastname VARCHAR(200),
            age integer, 
            password VARCHAR(200),
            email VARCHAR(200)
        )"
        return @db
    end

    def self.create(user_info)
        @db = self.connection
        @db.execute "INSERT INTO users (firstname, lastname, age, password, email) values(?,?,?,?,?)" , user_info['firstname'], user_info['lastname'], user_info['age'], user_info['password'], user_info['email'],  
        new_user_id = @db.last_insert_row_id
        @db.close
        return new_user_id
    end

    def self.find(user_id)
        @db = self.connection
        user = @db.query "SELECT * FROM users WHERE id = #{user_id}"
        @db.close
        return user
    end

    def self.all
        @db = self.connection
        users = @db.query "SELECT *FROM users"
        @db.close
        return users
    end

    def self.update(user_id, attribute, value)
        @db = self.connection
        @db.execute "UPDATE users SET #{attribute}='#{value}' WHERE id=#{user_id}"
        user = @db.execute "SELECT * FROM users where id  =#{user_id}"
        @db.close
        return user
    end

    def destroy(user_id)
        @db = self.connection
        dest_user = @db.execute "DELETE FROM users WHERE id=#{user_id}"
        @db.close
        return dest_user
    end

    def self.auth(password, email)
        @db = 

 end
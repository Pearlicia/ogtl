require 'sqlite3'
 class User
    atrr_accessor :id, :firstname, :lastname, :age, 
    def initialize
        @db = SQLite3::Database.open 'db.sql'
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
        );"
    end

    def create(user_info)
       
        @db.execute "INSERT INTO users (firstname, lastname, age, password, email) values('#{user_info['firstname']}', '#{user_info['lastname']}', #{user_info['age']}, '#{user_info['password']}', '#{user_info['email']}')"
        return @db.query "SELECT id FROM users WHERE email = #{user_info['email']}"
    end

    def find(user_id)
        return @db.query "SELECT id, firstname, lastname, age, email FROM users WHERE id = #{user_id}"
    end

    def all
        return @db.query "SELECT id, firstname, lastname, age, email FROM users"
    end

    def update(user_id, attribute, value)
        @db.execute "UPDATE users SET #{attribute}='#{value}' WHERE id=#{user_id}"
    end

    def destroy(user_id)
        puts 'here'
        @db.execute "DELETE FROM users WHERE id=#{user_id}"
    end

 end
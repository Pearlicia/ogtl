require 'sqlite3'
 class User
        
    def initialize
        @db = SQLite3::Database.open 'db.sql'
        @db.results_as_hash = true
        #create table
        @db.execute "CREATE TABLE IF NOT EXISTS users
        (
            id int,
            firstname, lastname, age, password, email)"
    end

    def create(user_info)
        puts user_info['lastname']
        @db.execute "INSERT INTO users (firstname, lastname, age, password, email) values('#{user_info['firstname']}', '#{user_info['lastname']}', '#{user_info['age']}', '#{user_info['password']}', '#{user_info['email']}')"
    end

    def find(user_id)
        return @db.query "SELECT * FROM users WHERE id = #{user_id}"
    end

    def all
        return @db.query "SELECT * FROM users"
    end

    def update(user_id, attribute, value)
        @db.execute "UPDATE users SET #{attribute}='#{value}' WHERE id=#{user_id}"
    end

    def destroy(user_id)
        @db.execute "DELETE FROM users WHERE id=#{user_id}"
    end

 end
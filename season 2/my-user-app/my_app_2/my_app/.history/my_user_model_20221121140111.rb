require 'sqlite3'
 class User
    db = SQLite3::Database.open 'db.sql'
    db.results_as_hash = true
    #create table
    db.execute "CREATE TABLE IF NOT EXISTS users(id, firstname, lastname, age, password, email)"


    def create(user_info)
        db.execute "INSERT INTO users (firstname, lastname, age, password, email) values('#{user_info.firstname}', '#{user_info.lastname}', #{user_info.age},#{user_info.password}, '#{user_info.email}')"
    end

    def find(user_id)
    end

    def all
        db.query = "S"
    end

    def update(user_id, attribute, value)
    end

    def destroy(user_id)
    end

 end
require 'sqlite3'
 class User
    db = SQLite3::Database.open 'db.sql'
    db.results_as_hash = true
    #create table
    db.execute "CREATE TABLE IF NOT EXISTS users(id, firstname, lastname, age, password, email)"


    def create(user_info)
    end

    def find(user_id)
    end

    def all
    end

 end
require 'sqlite3'
require 'json'
require 'sinatra'

class User < Sinatra::Base
    def initialize
        @db = SQLite3::Database.new(db.sql)
    end

  
    def self.create(user_info)
        @db = SQLite3::Database.new 'db.sql'
        @db.execute "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, age INTEGER, password TEXT, email TEXT)"
        
        firstname = user_info['firstname']
        lastname = user_info['lastname']
        age = user_info['age']
        password = user_info['password']
        email = user_info['email']

        @db.execute "INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)", firstname, lastname, age, password, email
        id = @db.last_insert_row_id
        return id
    end

    def self.find(user_id)
        @db = SQLite3::Database.new 'db.sql'

        @db.results_as_hash = true
        query = "SELECT * FROM users WHERE id = ?"
        result = @db.execute(query, user_id).first
        { id: result[0], firstname: result[1], lastname: result[2], age: result[3],  email: result[5] }
        result
    end

    def self.all
        @db = SQLite3::Database.new 'db.sql'

        @db.results_as_hash = true
        query = "SELECT * FROM users"
        users = {}
        @db.execute(query).each do |result|
            users[result[0]] = { id: result[0], firstname: result[1], lastname: result[2], age: result[3], email: result[5] }
        end
        users  
    end

    def self.update(user_id, attribute, value)
        @db = SQLite3::Database.new 'db.sql'

        query = "UPDATE users SET #{attribute} = ? WHERE id = ?"
        @db.execute(query, value, user_id)
        find(user_id)
    end

    def self.destroy(user_id)
        @db = SQLite3::Database.new 'db.sql'

        @db.execute('DELETE FROM users WHERE id = ?', [user_id])
    end

    #   def self.authenticate(email, password)
    #     db = SQLite3::Database.new(DB_FILE)
    #     db.results_as_hash = true
    #     db.execute('SELECT * FROM users WHERE email = ? AND password = ?', [email, password]).first
    #   end
    end

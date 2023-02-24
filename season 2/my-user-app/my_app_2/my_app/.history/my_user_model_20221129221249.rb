require 'sqlite3'
 class User
    attr_accessor :id, :firstname, :lastname, :age, :password, :email
    def initialize (id=0, firstname, lastname, age, password, email)
      
    end

    def self.connection
        
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
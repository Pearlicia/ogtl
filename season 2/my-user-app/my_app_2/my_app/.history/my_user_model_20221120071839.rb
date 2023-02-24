require 'sqlite3'
 class User
    db = SQLite3::Database.open 'db.sql'
    db.results_as_hash = true
    


 end
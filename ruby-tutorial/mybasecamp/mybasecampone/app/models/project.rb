class Project < ApplicationRecord
    belongs_to :user, optional: true
    has_many :members    
    resourcify
    
    validates :name, presence: true, length: {minimum: 5, maximum: 50}
    validates :description, presence: true, length: {minimum: 10, maximum: 1000}

  
    

end

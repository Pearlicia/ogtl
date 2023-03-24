class Project < ApplicationRecord
    belongs_to :user
    has_many :members
    has_many :discussions, dependent: :destroy
    has_one_attached :image
    has_many_attached :pictures
    has_rich_text :body    
    resourcify
    
    validates :name, presence: true, length: {minimum: 5, maximum: 50}
    validates :description, presence: true, length: {minimum: 10, maximum: 1000}

  
    

end

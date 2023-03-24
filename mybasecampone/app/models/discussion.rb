class Discussion < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_rich_text :body
  has_one_attached :image
  has_many_attached :pictures
  
end

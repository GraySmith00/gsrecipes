class Comment < ApplicationRecord
  belongs_to :chef
  belongs_to :recipe
  
  validates :body, presence: true, length: { minimum: 3, maximum: 150 }
  validates :chef_id, presence: true
  validates :recipe_id, presence: true
  
  default_scope -> { order(updated_at: :desc) }
end
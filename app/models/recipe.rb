class Recipe < ApplicationRecord
  belongs_to :chef 
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy
  
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :description, presence: true, length: { minimum: 5, maximum: 2500 }
  validates :chef_id, presence: true
  
  # def self.by_order_desc
  #   order("created_at DESC")
  # end
  
  default_scope -> { order(updated_at: :desc) }
  

  
end
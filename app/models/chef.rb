class Chef < ApplicationRecord
  has_many :recipes, dependent: :destroy
  
  before_save { self.email = email.downcase }
  validates :chefname, presence: true, length: { minimum: 2, maximum: 30 }
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i 
  validates :email, presence: true, length: { maximum: 60 }, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  has_secure_password
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
  #allow_nil: true, will still require a password when creating a new record, but will allow update without password
  
  
  
end
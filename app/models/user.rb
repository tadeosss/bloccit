class User < ActiveRecord::Base
  enum role: [:member, :admin]
  has_many :posts
  
  #Callbacks
  before_save -> (){ self.email = email.downcase }, if: -> (){ email.present? }
  
  #Validations
  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }
  validates :role, presence: true,
    inclusion: { in: roles.keys , message: "%{value} is not a valid role" }
  
  has_secure_password
end
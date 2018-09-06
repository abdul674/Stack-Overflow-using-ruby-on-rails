class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	has_many :questions, dependent: :destroy
	has_many :comments
	has_many :votes

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	before_save { self.email = self.email.downcase }
	validates   :name,  presence:   true, length: { maximum: 50 }
	
	validates  :email, presence:   true, 
										 length:     { maximum: 50 }, 
										 format:     { with: VALID_EMAIL_REGEX },
										 uniqueness: { case_sensitive: false }

	validates  :password,  length: { minimum: 6 }, allow_blank: true
end

class User < ApplicationRecord
	has_many :resource_threads
	has_many :votes
	before_save :encrypt_password
	validates :username, presence: true, length: { maximum: 20 }, uniqueness: true
	validates :password, presence: true, length: { maximum: 128 }, confirmation: true

	def encrypt_password
		self.salt = BCrypt::Engine.generate_salt
		self.password = BCrypt::Engine.hash_secret(password, salt)
	end

	def self.authenticate(username_input="", password_input="")
		
		user = User.find_by_username(username_input)
		
		if user && user.match_password(password_input)
			return user
		else
			return false
		end
	end   

	def match_password(password_input="")
		password == BCrypt::Engine.hash_secret(password_input, salt)
	end

end

class User < ApplicationRecord
	before_save :encrypt_password
	validates :username, presence: true, length: { maximum: 8 }, uniqueness: true
	validates :password, presence: true, length: { maximum: 128 }, confirmation: true

	def encrypt_password
		self.salt = BCrypt::Engine.generate_salt
		self.password = BCrypt::Engine.hash_secret(password, salt)
	end
end

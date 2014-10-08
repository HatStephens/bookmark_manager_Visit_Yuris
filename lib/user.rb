require 'bcrypt'
class User

	include DataMapper::Resource

	property :id,								Serial
	property :email,						String, unique: true, message: "This email is already taken"

	property :password_digest,	Text

	attr_reader :password
	attr_accessor :password_confirmation  #needed because we're now passing the confirmation to the model in the controller

	# this is datamapper's method of validating the model.
	# The model will not be saved unless both password
	# and password_confirmation are the same
	# read more about it in the documentation
	# http://datamapper.org/docs/validations.html
	validates_confirmation_of :password,  message: "Sorry, your passwords don't match"

	
	# validates_uniqueness_of :email   This is not necessary because we created a unique index automatically 

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	# def password
  #   BCrypt::Password.new(password_digest)
  # end

end
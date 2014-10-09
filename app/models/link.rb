# This class coresponds to a table in the database
# We can use it to manipulate the data

require_relative 'tag'

class Link

	# This makes the instances of this class Datamapper resources
	include DataMapper::Resource

	has n, :tags, through: Resource

	# This block describes what resources our model will have
	property :id,			Serial # Serial means it will be auto-incremented for every record
	property :title,	String
	property :uri,		String

end
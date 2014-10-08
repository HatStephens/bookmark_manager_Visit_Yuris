require 'data_mapper'
require 'sinatra'
require './lib/link'
require './lib/tag'
require './lib/user'
require 'rack-flash'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

# set :views, Proc.new {File.join(root, '..', 'views')}  NO LONGER NEEDED DUE TO NEW STRUCTURE

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
	@links = Link.all
	erb :index
end

post '/links' do
	uri = params["uri"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
		Tag.first_or_create(text: tag)
	end
	Link.create(uri: uri, title: title, tags: tags)
	redirect to '/'
end

get '/tags/:text' do
	tag = Tag.first(text: params[:text])
	@links=  tag ? tag.links : []
	erb :index
end

get '/users/new' do
	@user = User.new
	erb :"users/new"  #using quotes here otherwise will try and divide users by new!
end

post '/users' do
	@user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to '/'
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end


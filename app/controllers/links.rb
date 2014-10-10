post '/links' do
	uri = params["uri"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
		Tag.first_or_create(text: tag)
	end
	Link.create(uri: uri, title: title, tags: tags)
	redirect to '/'
end

get '/links/new' do
  erb :"links/new"
end
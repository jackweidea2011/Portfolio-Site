get '/' do
  @title = 'Home'
  haml :index
end

get '/about' do
  @title = 'About'
  haml :about
end

get '/contact' do
  @title = 'Contact'
  haml :contact
end

get '/stylesheets/:name.:ext' do
  scss :"stylesheets/#{params[:name]}"
end
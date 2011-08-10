get '/login' do
  redirect '/sessions/new'
end

get '/sessions/new' do
  @title = 'Log in'
  @user = User.new
  haml :'sessions/new'
end

post '/sessions' do
  user = User.authenticate(params[:user][:email], params[:user][:password])
  if user
    session[:user] = user
    session[:username] = user.email
    flash :success => "Logged in as #{user.email}!"
    haml :index
  else
    @user = User.new(:email => params[:user][:email])
    flash :notice => 'The details provided were incorrect'
    haml :'sessions/new'
  end
end

get '/logout' do
  session[:user] = nil
  session[:username] = nil
  flash :success => 'Logged out successfully!'
  haml :index
end
get '/users' do
  @title = 'All users'
  @users = User.all
  haml :'users/index'
end

get '/user/:id' do
  @title = 'User Profile'
  @user = Project.get(params[:id])
  haml :'users/show'
end
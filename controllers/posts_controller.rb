
# INDEX
get '/posts' do
  @posts = Post.all(:order => [ :date_created.desc ])
  haml :'posts/index'
end

# SHOW
get '/post/:id' do
  @post = Post.get(params[:id])
  haml :'posts/show'
end

# NEW
get '/posts/new' do
  authenticate!
  @post = current_user.posts.new
  haml :'posts/new'
end

# CREATE
post '/posts' do
  authenticate!
  @post = Post.new(params[:post].merge(:author => current_user.email, :date_created => DateTime.now))
  if @post.save
    redirect "/post/#{@post.id}"
  else
    haml :'posts/new'
  end
end

# EDIT
get '/post/:id/edit' do
  authenticate!
  @post = Post.get(params[:id])
  haml :'posts/edit'
end

# UPDATE
put '/post/:id' do
  authenticate!
  @post = Post.get(params[:id])
  if @post.update(params[:post])
    redirect "/post/#{@post.id}"
  else
    haml :'posts/edit'
  end
end

# DELETE
delete '/post/:id' do
  authenticate!
  @post = Post.get(params[:id])
  @post.destroy
  redirect '/posts'
end
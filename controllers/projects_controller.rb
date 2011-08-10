# INDEX
get '/projects' do
  @projects = Project.all(:order => [ :date_created.desc ])
  haml :'projects/index'
end

# SHOW
get '/project/:id' do
  @project = Project.get(params[:id])
  haml :'projects/show'
end

# NEW
get '/projects/new' do
  authenticate!
  @project = current_user.projects.new
  haml :'projects/new'
end

# CREATE
post '/projects' do
  authenticate!
  @project = Project.new(params[:project].merge(:date_created => DateTime.now))
  if @project.save
    redirect "/project/#{@project.id}"
  else
    flash[:notice] = 'Project not valid'
    haml :'projects/new'
  end
end

# EDIT
get '/project/:id/edit' do
  authenticate!
  @project = Project.get(params[:id])
  haml :'projects/edit'
end

# UPDATE
put '/project/:id' do
  authenticate!
  @project = Project.get(params[:id])
  if @project.update(params[:project])
    redirect "/project/#{@project.id}"
  else
    haml :'projects/edit'
  end
end

# DELETE
delete '/project/:id' do
  authenticate!
  @project = Project.get(params[:id])
  @project.destroy
  redirect '/projects'
end
require 'rubygems'
require 'sinatra'
require 'haml'
require 'data_mapper'

configure do
  require File.join(File.dirname(__FILE__), 'config', 'app_config.rb')
  set :haml, :format => :html5
  set :public, 'public'
  use Rack::Session::Pool
  Dir[File.expand_path(File.join(File.dirname(__FILE__),"controllers/*.rb"))].each {|f| require f}
  Dir[File.expand_path(File.join(File.dirname(__FILE__),"models/*.rb"))].each {|f| require f}
  DataMapper.auto_upgrade!
  DataMapper.finalize
end

before do
  @flash = {}
end

helpers do
  def flash(options={})
    @flash.merge!(options)
  end
  
  def current_user
    session[:user]
  end
  
  def signed_in?
    !session[:user].nil?
  end
  
  def authenticate!
    unless signed_in?
      redirect '/login'
    end
  end
end


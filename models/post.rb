require 'dm-validations'
require 'dm-constraints'

class Post
  include DataMapper::Resource
  
  has n, :comments, :constraint => :destroy
  
  property :id, Serial
  property :title, String
  property :content, Text
  property :date_created, DateTime
  property :author, String
  
  belongs_to :user
end
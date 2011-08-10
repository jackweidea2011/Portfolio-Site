require 'dm-validations'
require 'dm-constraints'

class Comment
  include DataMapper::Resource
  
  property :id, Serial
  property :author, String
  property :content, Text
  property :date_created, DateTime
  
  belongs_to :post
end
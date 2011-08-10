require 'dm-validations'
require 'dm-constraints'

class Project
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :description, Text
  property :image_url, String
  property :project_url, String
  property :date_created, DateTime
  
  belongs_to :user
end
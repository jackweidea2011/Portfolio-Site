require 'dm-validations'
require 'dm-constraints'
require 'digest/sha1'

class User
  include DataMapper::Resource
  
  has n, :posts, :constraint => :destroy
  has n, :projects, :constraint => :destroy
  
  attr_accessor :password, :password_confirmation
  
  property :id, Serial
  property :email, String, :required => true, :unique => true, :format => :email_address,
    :messages => {
      :required => 'An email address must be provided',
      :unique   => 'That email address is already in use',
      :format   => 'Not recognised as a valid email address'
    }
  property :hashed_password, String, :required => true
  property :salt, String, :required => true
  
  validates_presence_of :password, :password_confirmation
  validates_confirmation_of :password
  
  before :valid?, :set_hashed_password
  
  def has_password?(pass)
    hashed_password == encrypt_password(pass, salt)
  end
  
  private
  
  def set_hashed_password
    self.salt ||= generate_salt
    self.hashed_password = encrypt_password(password, salt)
  end
  
  def generate_salt
    random_string = (0..25).map{ ('a'..'z').to_a[rand(26)] }.join
    Digest::SHA1.hexdigest(random_string)
  end
  
  def encrypt_password(password, salt)
    Digest::SHA1.hexdigest(password + salt)
  end
  
  class << self
    def authenticate(email, password)
      user = first(:email => email)
      return nil if user.nil?
      user.has_password?(password) ? user : nil
    end
  end
end
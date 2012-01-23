class Account
  include Mongoid::Document
  attr_accessor :password, :password_confirmation

  # Fields
  field :surname,          :type => String
  field :email,            :type => String
  field :crypted_password, :type => String
  field :role,             :type => String, :default => 'none'
  field :uid,              :type => String

  has_many :votes

  ##
  # This method is used by AuthenticationHelper
  #
  def self.find_by_id(id)
    find(id) rescue nil
  end

  def self.find_or_create_with_ominiauth(auth)
    find_or_create_by(uid: auth['uid']) do |a|
      a.surname = auth['info']['nickname']
      a.email = auth['info']['email']
    end
  end
  
end

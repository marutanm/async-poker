class Account
  include Mongoid::Document
  attr_accessor :password, :password_confirmation

  # Fields
  field :name,             :type => String
  field :surname,          :type => String
  field :email,            :type => String
  field :crypted_password, :type => String
  field :role,             :type => String, :default => 'none'
  field :uid,              :type => String

  def self.authenticate(email, password)
    account = first(:conditions => { :email => email }) if email.present?
    account && account.has_password?(password) ? account : nil
  end

  ##
  # This method is used by AuthenticationHelper
  #
  def self.find_by_id(id)
    find(id) rescue nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  def self.find_or_create_with_ominiauth(auth)
    find_or_create_by(uid: auth['uid']) do |a|
      a.surname = auth['info']['nickname']
      a.email = auth['info']['email']
    end
  end

  def self.voter
    where(role: 'member') + where(role: 'admin')
  end

  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(self.password)
  end

end

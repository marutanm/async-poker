class User
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields
  field :nickname
  field :uid

  has_many :votes

  def self.find_or_create_by_ominiauth(auth)
    user = find_or_create_by(uid: auth['uid']) do |u|
      u.nickname = auth['info']['nickname']
    end
  end

  def self.find_by_uid(uid)
    where(uid: uid).first rescue nil
  end
  
end

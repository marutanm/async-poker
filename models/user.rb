class User
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields
  field :name
  field :uid

  has_many :votes

end

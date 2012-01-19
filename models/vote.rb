class Vote
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :value

  belongs_to :user

end

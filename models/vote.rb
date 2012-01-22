class Vote
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  belongs_to :story
  belongs_to :user

  field :value

end

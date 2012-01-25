class Vote
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  embedded_in :story

  field :account_id
  field :value, type: Integer

  validates_presence_of :account_id

end

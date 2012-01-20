class Story
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields
  field :story_id
  field :name
  field :description
  field :estimate
  field :state, type: Boolean, default: false

  embeds_many :votes

end

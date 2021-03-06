class Story
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :story_id
  field :name
  field :description
  field :estimate, type: Integer
  field :state, type: Boolean, default: false

  embeds_many :votes

  def self.to_vote
    where(estimate: -1, state: false)
  end

  def self.voted
    where(estimate: -1, state: true)
  end

  def self.estimated
    where("this.estimate != -1")
  end

  def selected?(account, value)
    votes.where(:account_id => account.id.to_s).first.value == value rescue nil
  end

end

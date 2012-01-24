class Vote
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  belongs_to :story
  belongs_to :account

  field :value, type: Integer

  def self.update_value_with(params)
    find_or_create_by(story_id: params[:story_id], account_id: params[:account_id]) do |v|
      v.value = params[:value]
    end
  end

end

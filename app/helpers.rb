# Helper methods defined here can be accessed in any controller or view in the application

AsyncPoker.helpers do

  def pivotal
    @pivotal ||= PivotalTracker::Project.find(ENV['PROJECT_ID'])
  end

  def get_and_save_feature
    pivotal.stories.all(:story_type => 'feature').each do |story|
      Story.find_or_create_by(story_id: story.id) do |s|
        s.name = story.name
        s.description = story.description
        s.estimate = story.estimate
        s.state = true if story.estimate > 0
      end
    end
  end

  def member?
    current_account && current_account.role == 'member'
  end

  def admin?
    current_account && current_account.role == 'admin'
  end

  def check_voted(story_id)
    story = Story.find(story_id)
    story.state = true if story.votes.count >= Account.voter.count
    story.save
  end

  def short_name(account_id)
    Account.find(account_id).surname[0..3]
  end

  def fibonacci
    [0, 1, 2, 3, 5, 8]
  end

end

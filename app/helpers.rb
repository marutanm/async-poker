# Helper methods defined here can be accessed in any controller or view in the application

AsyncPoker.helpers do

  def get_and_save_feature
    project = PivotalTracker::Project.find(ENV['PROJECT_ID'])
    project.stories.all(:story_type => 'feature').each do |story|
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

end

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

  def authorized?(auth)
    ENV['AUTHORIZE'].split(',').include? auth['info']['nickname']
  end

  def set_current_user(user)
    session[:uid] = user.uid
  end

  def current_user
    User.find_by_uid(session[:uid])
  end

end

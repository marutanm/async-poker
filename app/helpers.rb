# Helper methods defined here can be accessed in any controller or view in the application

AsyncPoker.helpers do

  def get_and_save_feature
    project = PivotalTracker::Project.find(ENV['PROJECT_ID'])
    project.stories.all(:story_type => 'feature').each do |story|
      logger.info story.name
      Story.create(story_id: story.id,
                   name: story.name,
                   description: story.description,
                   estiname: story.estimate
                  )
    end
  end
end

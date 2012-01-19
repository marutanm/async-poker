AsyncPoker.controllers  do

  get :index do
  end

  get :update do
    Pivotal.find(:all, :params => {:project_id => ENV['PROJECT_ID'], :filter => 'story_type:feature'}).to_s
  end

end

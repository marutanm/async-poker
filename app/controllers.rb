AsyncPoker.controllers  do

  get :index do
    RestClient.get "http://www.pivotaltracker.com/services/v3/projects/#{ENV['PROJECT_ID']}/stories", {'X-TrackerToken' => ENV['TOKEN'] }
  end

end

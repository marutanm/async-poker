# Helper methods defined here can be accessed in any controller or view in the application

AsyncPoker.helpers do

  def get_and_save_stories
    noko = Nokogiri::XML(RestClient.get "http://www.pivotaltracker.com/services/v3/projects/#{ENV['PROJECT_ID']}/stories", {'X-TrackerToken' => ENV['TOKEN'] })

    noko.xpath("//story").each do |n|
      Story.create(id: n.xpath("id").text, name: n.xpath("name").text)
    end

  end

end

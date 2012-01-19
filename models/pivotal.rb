require 'active_resource'
class Pivotal < ActiveResource::Base

  headers['X-TrackerToken'] = ENV['TOKEN']
  
  self.site = "http://www.pivotaltracker.com/"
  self.prefix = "/services/v3/projects/:project_id/"
  self.collection_name = "stories"
  self.format = :xml
  
  self.logger = Logger.new($stderr)

end


require 'active_resource'
class Pivotal < ActiveResource::Base

  headers['X-TrackerToken'] = ENV['TOKEN']
  
  self.site = "http://www.pivotaltracker.com/services/v3"
  self.element_name = "projects"
  self.format = :xml
  
  self.logger = Logger.new($stderr)

end


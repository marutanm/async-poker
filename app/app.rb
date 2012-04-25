class AsyncPoker < Padrino::Application
  register ScssInitializer
  register OmniauthInitializer
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  enable :sessions
  configure :development do
    register BaristaInitializer
  end

  PivotalTracker::Client.token = ENV['TOKEN']

  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  end

  use Rack::Pjax

  register Padrino::Admin::AccessControl

  set :login_page, "/auth/github"

  access_control.roles_for :any do |role|
    role.allow "/auth/github/*"
    role.allow "/welcome"
    role.allow "/logout"
    role.protect "/*"
  end

  access_control.roles_for :member do |role|
    role.allow "/"
    role.allow "/update"
  end

  access_control.roles_for :admin do |role|
    role.allow "/"
    role.allow "/update"
    role.allow "/admin"
  end

end

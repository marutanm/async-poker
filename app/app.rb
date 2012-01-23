class AsyncPoker < Padrino::Application
  register OmniauthInitializer
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  enable :sessions

  PivotalTracker::Client.token = ENV['TOKEN']

  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  end

  register Padrino::Admin::AccessControl

  set :login_page, "/auth/github"

  access_control.roles_for :any do |role|
    role.allow "/auth/github/"
    role.allow "/auth/github/callback"
    # role.protect "/"
  end

  access_control.roles_for :member do |role|
    role.allow "/"
    role.allow "/update"
  end

  access_control.roles_for :admin do |role|
    role.allow "/admin"
  end

end

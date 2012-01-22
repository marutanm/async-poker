AsyncPoker.controllers  do

  get '/auth/github/callback' do
    auth = request.env["omniauth.auth"]
    if authorized?(auth)
      user = User.find_or_create_by_ominiauth(auth)
      set_current_user(user)
      redirect url(:index)
    else
      halt 401
    end
  end

  get :index do
    @stories = Story.all.each
    haml :index
  end

  get :update do
    get_and_save_feature
    redirect url(:index)
  end

end

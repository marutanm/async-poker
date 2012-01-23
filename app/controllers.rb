AsyncPoker.controllers  do

  get '/auth/github/callback' do
    auth = request.env["omniauth.auth"]
    account = Account.find_or_create_by_ominiauth(auth)
    set_current_account(account)
    redirect url(:index)
  end

  get :logout do
    set_current_account(nil)
    redirect url(:index)
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

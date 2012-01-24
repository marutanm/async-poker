AsyncPoker.controllers  do

  get '/auth/github/callback' do
    auth = request.env["omniauth.auth"]
    logger.info auth
    account = Account.find_or_create_with_ominiauth(auth)
    logger.info account
    set_current_account(account)
    if member? || admin?
      redirect url(:index)
    else
      redirect url(:welcome)
    end
  end

  get :welcome do
    "Welcome #{current_account.surname}"
  end

  get :logout do
    set_current_account(nil)
    redirect url(:index)
  end

  get :index do
    logger.info current_account
    @to_vote = Story.to_vote
    @voted = Story.voted
    @estimated = Story.estimated
    haml :index
  end

  get :update do
    get_and_save_feature
    redirect url(:index)
  end

end

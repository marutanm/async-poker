AsyncPoker.controllers  do

  get '/auth/github/callback' do
    auth = request.env["omniauth.auth"]
    account = Account.find_or_create_with_ominiauth(auth)
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
    @to_vote = Story.to_vote
    @voted = Story.voted
    @estimated = Story.estimated
    haml :index
  end

  post :index do
    story = Story.find(params[:story_id])
    v = story.votes.find_or_create_by(account_id: current_account.id)
    v.value = params[:value]
    v.save
    redirect url(:index)
  end

  get :update do
    get_and_save_feature
    redirect url(:index)
  end

end

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
    v = story.votes.find_or_create_by(account_id: current_account.id.to_s)
    v.value = params[:value]
    v.save
    check_voted(story.id)
    200
  end

  get :story, :with => :story_id do
    story = Story.where(story_id: params[:story_id].to_i).first
    render :vote, :locals => {story: story}
  end

  get :update do
    get_and_save_feature
    redirect url(:index)
  end

end

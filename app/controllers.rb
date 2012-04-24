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
    stories = pivotal.stories.all(:story_type => 'feature', :current_state => ['unscheduled', 'unstarted'])
    render :index, :locals => {stories: stories}
  end

  get :story, :with => :story_id do
    story = pivotal.stories.find(params[:story_id])
    halt 404 unless story
    render :vote, :locals => {story: story}
  end

  get :update do
    get_and_save_feature
    redirect url(:index)
  end

end

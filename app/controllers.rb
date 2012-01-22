AsyncPoker.controllers  do

  get :index do
    @stories = Story.all.each
    haml :index
  end

  get :update do
    get_and_save_feature
    redirect url(:index)
  end

end

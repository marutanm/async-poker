AsyncPoker.controllers  do

  get :index do
  end

  get :update do
    get_and_save_feature
    200
  end

end

class NewsPostsController < ApplicationController
  make_resourceful do
    actions :all
    
    after(:update, :create) { flash[:notice] = "News post was successfully saved!" }
    after(:update_fails, :create_fails) { flash[:error] = "Your news post contained errors" }
  end
end


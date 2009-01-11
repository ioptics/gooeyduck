class NewsPostsController < ApplicationController
  make_resourceful do
    actions :all
    
    response_for :create do |format| 
      format.html {
        flash[:success] = 'Your news post was successfully created!'
        redirect_to news_posts_path
      }
      format.js
    end
    
    response_for :update do |format| 
      format.html {
        flash[:success] = 'Your news post was successfully updated!'
        redirect_to news_posts_path
      }
      format.js
    end
    
    response_for :update_fails do |format|
      format.html do
        flash[:error] = "We found errors when saving your news post!"
        render :action => :edit
      end
      format.js
    end
  end
end


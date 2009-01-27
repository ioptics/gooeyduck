require File.dirname(__FILE__) + '/../test_helper'

class NewsPostsControllerTest < ActionController::TestCase

  def setup
    @controller = NewsPostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "on GET :index" do
    setup { get :index }
    should_respond_with :success
    should_assign_to :news_posts
  end
  
  context "on GET :show" do
    setup { get :new }
    should_respond_with :success
  end

  context "on POST to :create" do
    setup { post :create, :news_post => {
      :title => 'Updated Test News Post', :body => 'Test News Post Body'} }
    
    should_change "NewsPost.count"
    should_set_the_flash_to /saved/i
    should_redirect_to 'news_post_path(@news_post)'
  end
  
  context "on GET :edit" do
    setup { get :edit, :id => 1 }
    should_respond_with :success
  end
  
  context "on POST to :update" do
    context "with valid data" do
      setup { put :update, :id => 1, :news_post => {
        :title => 'Updated Test News Post', :body => 'Test News Post Body'} }
      should_set_the_flash_to /saved/i
      should_redirect_to 'news_post_path(@news_post)'
    end
    
    context "with invalid data" do
      setup { put :update, :id => 1, :news_post => {:title => ''} }
      should_set_the_flash_to /errors/i
      should_render_template :edit
    end
  end
  

#
#  def test_should_destroy_news_post
#    old_count = NewsPost.count
#    delete :destroy, :id => 1
#    assert_equal old_count-1, NewsPost.count
#
#    assert_redirected_to news_posts_path
#  end
end

ActionController::Routing::Routes.draw do |map|
  map.resources :assets
  map.resources :news_posts, :as => 'blog'
  map.resources :tags
  map.root :controller => 'news_posts', :action => 'index'
end

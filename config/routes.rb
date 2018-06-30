Rails.application.routes.draw do
  resources :articles do 
     member do
        get 'add_favourite'
        get 'remove_favourite'
     end  
   end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "signup" => "signup#new"
  post "signup" => "signup#create"
  get "signin" => "session#new"
  post "signin" => "session#create"
  get "signout" => "session#destroy"
  get "favourite_articles" => "user#my_favourite"
  get "all_user" => "user#index"
  get "follow" => "user#follow"
  get "unfollow" => "user#unfollow"
  get "followees_articles" => "user#my_followees_articles"
  get "my_followers_list" => "user#my_followers_list"
  get "my_followed_list" => "user#my_followed_list"


  root to: 'articles#index'
end

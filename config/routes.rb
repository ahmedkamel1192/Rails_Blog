Rails.application.routes.draw do
  resources :articles do 
     member do
        put 'favourites'
        delete 'favourites'
     end  
   end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "signup" => "signup#new"
  post "signup" => "signup#create"
  get "signin" => "session#new"
  post "signin" => "session#create"
  delete "signout" => "session#destroy"
  get "favourite_articles" => "user#my_favourite"
  get "all_user" => "user#index"
  put "follow" => "user#follow"
  delete "unfollow" => "user#unfollow"
  get "followees_articles" => "user#my_followees_articles"
  get "my_followers_list" => "user#my_followers_list"
  get "my_followed_list" => "user#my_followed_list"


   # Api Routes
   namespace :api do
    namespace :v1 do
      post "signup" => "signup#create"
      get "users" => "user#index"
      post "signin" => "authentication#authenticate" 
      get "favourite_articles" => "user#my_favourite"
      put "follow" => "user#follow"
      delete "unfollow" => "user#unfollow"
      get "followees_articles" => "user#my_followees_articles"
      get "my_followers_list" => "user#my_followers_list"
      get "my_followed_list" => "user#my_followed_list"
    end
  end


  root to: 'articles#index'
end
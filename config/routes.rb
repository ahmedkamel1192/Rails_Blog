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
  # root to: '/'
end

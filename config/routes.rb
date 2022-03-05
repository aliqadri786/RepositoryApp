Rails.application.routes.draw do
  resources :repositories do
    member do
      delete 'remove_user/:user_id', :action => 'remove_user', :as => :remove_user
      post 'add_user', :action => 'add_user', :as => :add_user
    end
  end
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "repositories#index"
end

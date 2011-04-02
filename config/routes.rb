Tinkertask::Application.routes.draw do
  resources :users
  resource :user
  resource :session
  resources :lists do
    resources :items do
      collection do
        post :reorder
      end
    end
  end
  resources :feedbacks
  #match '/:controller(/:action(/:id))'
  #match '/login' => 'session#new', :as => :login, :via => get
  #match '/login' => 'session#create', :as => :login, :via => post
  #match '/logout' => 'session#destroy', :as => :logout, :via => delete
  match '/' => 'session#new'
end


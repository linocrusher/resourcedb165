Rails.application.routes.draw do
  get 'sessions/login'

  get 'sessions/login_attempt'

  post 'sessions/login_attempt'

  get 'sessions/logout'

  post 'sessions/logout'

  get 'users/:user_id/resource_threads' => 'resource_threads#index'

  post 'users/:user_id/resource_threads/new' => 'resource_threads#new'

  post 'users/:user_id/resource_threads/:id' => 'resource_threads#show'

  post 'users/:user_id/resource_threads/:id/edit' => 'resource_threads#edit'

  get 'home/index'

  resources :users do
    resources :resource_threads do
      resources :folders
      resources :resources
    end
  end

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

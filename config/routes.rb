Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index, :create, :show, :destroy]
      resources :products, only: [:index, :create, :show, :destroy]
      resources :orders, only: [:index, :create, :show, :destroy]
      resources :users, only: [:index, :create, :show, :destroy]
      resources :orders, only: [:index, :create, :show, :destroy]
      post 'login', to: 'authentication#login'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

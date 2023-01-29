Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index, :create, :update, :show, :destroy]
      resources :products, only: [:index, :create, :show, :update, :destroy]
      resources :orders, only: [:index, :create, :confirm_order, :show, :update, :destroy]
      resources :users, only: [:index, :create, :update, :show, :destroy]
      resources :reviews, only: [:index, :create, :show, :confirm_review, :update, :destroy]
      post 'login', to: 'authentication#login'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

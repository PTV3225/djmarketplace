Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Add the DJ controller routes excluding the index action
  resources :djs

  resources :bookings

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  get 'dashboard/show'
  devise_for :users
  root to: "pages#home"

  # Add the DJ controller routes excluding the index action
  resources :djs do
    resources :bookings, only: [:new, :create]
    resources :reviews, except: [:index, :show]
  end

  # Define the route for the dashboard
  get '/dashboard', to: 'dashboard#show', as: :dashboard


  get '/approve_booking/:id', to: 'bookings#approve', as: :approve_booking
get '/reject_booking/:id', to: 'bookings#reject', as: :reject_booking

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do
  root "static_pages#home"
  get  "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :sender_recipients, only: %i(create destroy)
  resources :followers, only: %i(index)
  resources :followings, only: %i(index)
end

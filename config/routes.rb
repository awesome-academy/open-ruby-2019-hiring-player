Rails.application.routes.draw do
  root "static_pages#home"
  get  "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :users do
    post "/rate", to: "ratings#create"
    resources :messengers
    resources :conversations, only: %(index)
  end
  resources :orders, only: %i(new create show)
  resources :sender_recipients, only: %i(index create update destroy)
  resources :followers, only: %i(index)
  resources :sender_recipients, only: %i(create destroy)
  resources :followers, only: %i(index) 
  resources :followings, only: %i(index)
  resources :comments, only: %i(create show destroy)
end

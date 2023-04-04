Rails.application.routes.draw do
  
  # Routing logic: fallback requests for React Router.
  # Leave this here to help deploy your app later!
  get "/me", to: "users#show"
  post "/login", to: "sessions#create"
  post "/signup", to: "users#create"
  delete "/logout", to: "sessions#destroy"
  delete "/reviews", to: "reviews#destroy"
  resources :reviews
  # resources :users
  resources :baked_goods

  get "/bios/:length", to: "users#bio_length"
  # get "/bakeries", to: "bakeries#index"
  # get "bakeries", to: "bakeries#show"
  # get "/bakedgoods", to: "baked_goods#index"
  # get "bakedgoods", to: "baked_goods#show"
  # post "/bakedgoods", to: "baked_goods#create"

  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }
end

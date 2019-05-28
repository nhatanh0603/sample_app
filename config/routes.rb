Rails.application.routes.draw do
  root "static_pages#home"

  #static_pages
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/help", to: "static_pages#help"
  #users
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/users/not_found", to: "users#not_found"
  resources :users
  #login
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#home"
  get "/home" => "home#home", as: :home

  get "/about" => "home#about", as: :about

  resources :posts

  resources :comments


end

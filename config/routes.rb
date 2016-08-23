Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#home"
  get "/home" => "home#home", as: :home

  get "/about" => "home#about", as: :about

  resources :posts

  resources :comments

  resources :users, only: [:show, :new, :create, :edit, :update]
  # UPDATE USER
  get "users/:id/password" => "users#edit_password", as: :user_password
  patch "users/:id/password" => "users#update_password"

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

end

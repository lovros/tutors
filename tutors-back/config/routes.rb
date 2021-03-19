Rails.application.routes.draw do
  resources :teachers
  resources :students
  resources :appointments
  resources :messages
  resource :accounts, only: [:create]
  post "/login", to: "accounts#login"
  get "/auto_login", to: "accounts#auto_login"
  post "/accounts/update", to: "accounts#update"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

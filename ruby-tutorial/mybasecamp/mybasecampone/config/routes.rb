Rails.application.routes.draw do
  resources :projects
  # get 'pages/home'
  get 'login', to: 'pages#login'
  # get 'pages/login'
  # get 'pages/register'
  get 'register', to: 'pages#register'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end

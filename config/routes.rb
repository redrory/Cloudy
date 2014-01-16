Cloudy::Application.routes.draw do

  resources :users
  #get "users/index"

  #get "users/new"

  #get "users/welcome"

  match "weather" => "users#weather"

  root :to => 'users#welcome'


end

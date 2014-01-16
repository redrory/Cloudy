Cloudy::Application.routes.draw do

  resources :users
  #get "users/index"

  #get "users/new"

  #get "users/welcome"

  match "weather" => "users#weather"
  match "hours" => "users#welcome"

  root :to => 'users#welcome'


end

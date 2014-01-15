Cloudy::Application.routes.draw do

  get "users/index"

  get "users/new"

  get "users/welcome"

   root :to => 'users#welcome'

end

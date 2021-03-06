Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :create]

  post '/login', to: 'auth#create'
  get '/current_user', to: 'auth#show'

end

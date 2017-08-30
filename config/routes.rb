Rails.application.routes.draw do
  get 'users/new'

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/contact-us', to: 'static_pages#contact_us'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # login / logout
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end

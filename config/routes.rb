Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "videos#index"
  get '/videos/:id', to: 'videos#show', as: 'video'
  resources :sessions, only: [:new, :create, :destroy]
  get '/signin', to: 'sessions#new', as: 'signin'
  delete '/signout',  to: 'sessions#destroy', as: 'signout'
end

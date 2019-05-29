Rails.application.routes.draw do
  root 'videos#index'
  get 'videos/:id' => 'videos#show', as: 'show_video'
  get 'sessions', to: 'sessions#new' 
  post 'sessions', to:'sessions#create'
  delete 'sessions', to: 'sessions#destroy'
  resources :videos, only: [:index]
end

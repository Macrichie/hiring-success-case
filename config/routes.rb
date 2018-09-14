Rails.application.routes.draw do
  resources :hirings
  resources :skills
  resources :areas
  resources :cities
  get 'hirings/upload/new', to: 'hirings#new_upload'
  post 'hirings/upload', to: 'hirings#upload'
end

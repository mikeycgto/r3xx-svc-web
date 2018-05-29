Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :links, except: :show
end

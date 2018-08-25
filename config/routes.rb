Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :links, except: %i(show edit update) do
    resources :hits, only: :index
  end
end

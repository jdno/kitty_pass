Rails.application.routes.draw do
  devise_for :users

  get 'settings', to: 'static_pages#settings'

  resources :adonis
end

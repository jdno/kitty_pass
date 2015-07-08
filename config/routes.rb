Rails.application.routes.draw do
  devise_for :users

  root 'adonis#index'

  concern :networkable do
    resources :network_interfaces, except: [:index, :show], shallow: true
  end

  get 'settings', to: 'static_pages#settings'

  resources :adonis, concerns: :networkable
  resources :locations
  resources :models, except: [:index, :show]
  resources :statuses, except: [:index, :show]
end

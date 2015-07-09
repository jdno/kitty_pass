Rails.application.routes.draw do
  get 'users/index'

  devise_for :users, skip: :registrations
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  root 'adonis#index'

  concern :networkable do
    resources :network_interfaces, except: [:index, :show], shallow: true
  end

  get 'settings', to: 'static_pages#settings'

  resources :adonis, concerns: :networkable
  resources :locations
  resources :models, except: [:index, :show]
  resources :proteus, concerns: :networkable
  resources :statuses, except: [:index, :show]
  resources :users, only: [:create, :destroy, :index, :new]
end

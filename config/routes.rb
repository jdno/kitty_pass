Rails.application.routes.draw do
  devise_for :users, skip: :registrations
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  root 'static_pages#statistics'

  concern :networkable do
    resources :network_interfaces, except: [:index, :show], shallow: true
  end

  get 'settings',   to: 'static_pages#settings',   as: 'settings'
  get 'statistics', to: 'static_pages#statistics', as: 'statistics'

  resources :adonis,  concerns: :networkable
  resources :proteus, concerns: :networkable

  resources :locations
  resources :models,   except: [:index, :show]
  resources :statuses, except: [:index, :show]
  resources :users,    only: [:create, :destroy, :index, :new]
  resources :xha,      except: :index, concerns: :networkable
end

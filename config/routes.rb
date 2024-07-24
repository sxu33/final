Rails.application.routes.draw do
  # Devise routes for users and admin_users
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # User account and addresses management
  resource :user, only: [:show], as: :user_account
  resources :addresses, except: [:index, :show]

  # Cart management
  resource :cart, only: [:show] do
    post 'add_item', to: 'carts#add_item'
    delete 'remove_item', to: 'carts#remove_item'
    patch 'update_item', to: 'carts#update_item'
  end

  # Products and categories management
  resources :products, only: [:index, :show] do
    collection do
      get 'search'
      get 'on_sale'
    end
  end
  resources :categories, only: [:index, :show]

  # Static pages
  get 'about', to: 'about#show'
  get 'contact', to: 'contact#show'

  # Root path
  root 'products#index'
end

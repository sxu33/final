Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resource :user, only: [:show], as: :user_account
  resources :addresses, except: [:index, :show]
   resources :orders, only: [:new, :create, :show] do
    member do
      get 'invoice'
    end
    collection do
      post 'create_address'
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, only: [:index, :show] do
    collection do
      get 'search'
      get 'on_sale' 
    end
  end

  resources :categories, only: [:index, :show]

  resource :cart, only: [:show] do
    post 'add_item', to: 'carts#add_item'
    delete 'remove_item', to: 'carts#remove_item'
    patch 'update_item', to: 'carts#update_item'
    get 'checkout', to: 'carts#checkout'
  end
  
  get 'about', to: 'about#show'
  get 'contact', to: 'contact#show'

  root 'products#index'
end

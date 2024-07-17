Rails.application.routes.draw do
  get 'carts/show'
  get 'carts/add_item'
  get 'carts/remove_item'
  get 'carts/update_item'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Routes for the customer views
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
  end
  
  get 'about', to: 'about#show'
  get 'contact', to: 'contact#show'

  # Root path
  root 'products#index'
end

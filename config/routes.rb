Rails.application.routes.draw do
  # Routes for the customer views
  resources :products, only: [:index, :show] do
    collection do
      get 'search'
      get 'on_sale'
      get 'new_arrivals'
      get 'recently_updated'
    end
  end

  resources :categories, only: [:index, :show]

  get 'about', to: 'about#show'
  get 'contact', to: 'contact#show'

  # Root path
  root 'products#index'
end

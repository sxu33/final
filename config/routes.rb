Rails.application.routes.draw do
  resources :products, only: [:index, :show] do
    collection do
      get 'search'
      get 'on_sale'
      get 'new_arrivals'
      get 'recently_updated'
    end
  end

  resources :categories, only: [:index, :show]

  root 'products#index'
end

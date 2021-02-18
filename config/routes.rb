Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :invoices
  resources :items
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        get 'items', to: 'merchants/items#index'
      end
      resources :items do
        get 'merchant', to: 'items/merchant#index'
      end
    end
  end
end

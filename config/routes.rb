Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/most_items', to: 'most_items#index'
      end

      namespace :items do
        get '/find_all', to: 'search#index'
        get '/revenue', to: 'revenue#index'
      end

      resources :merchants, only: [:index, :show] do
        get 'items', to: 'merchants/items#index'
      end

      resources :items do
        get 'merchant', to: 'items/merchant#index'
        get 'find_all', to: 'search/#index'
      end
    end
  end
end

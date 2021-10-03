Rails.application.routes.draw do
  defaults format: :json do
    namespace :v1 do
      resources :accounts do
        get '/transactions', to: 'accounts#transactions'
      end
      resources :transactions, only: :create
    end
  end

  match '*path', via: :all, to: 'application#route_not_found'
end

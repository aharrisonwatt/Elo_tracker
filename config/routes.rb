Rails.application.routes.draw do
  root "static_pages#root"

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index, :create]
    resource :session, only: [:create, :destroy, :show]
    resources :matches, only: [:index, :create, :show, :update]
    resources :ratings, only: [:index, :show]
  end
end

Rails.application.routes.draw do
  root "static_pages#root"

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:show]
    resources :ratings, only: [:index]
    resources :tournaments, only: [:index]
    get 'users/:username/opponent/:opponent/game/:game_name', to: 'users#compare'
  end
end

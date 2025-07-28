Rails.application.routes.draw do
  get 'home/index'
  root "home#index"

  resources :fonts, only: [:index, :show]
end

Rails.application.routes.draw do
  root "home#index"

  resources :fonts, only: [:show]
end

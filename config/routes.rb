Rails.application.routes.draw do
  root "home#index"
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  resources :fonts, only: [:show]
end

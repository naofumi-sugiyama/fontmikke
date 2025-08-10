Rails.application.routes.draw do
  get 'static_pages/terms'
  get 'static_pages/privacy'
  root "home#index"
  get 'terms_of_service', to: 'static_pages#terms_of_service'
  resources :fonts, only: [:show]

  # 静的ページ
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
end

Rails.application.routes.draw do
  get 'static_pages/terms'
  get 'static_pages/privacy'
  root "home#index"

  resources :fonts, only: [:show]

  # 静的ページ
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
end

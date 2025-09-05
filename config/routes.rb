Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'static_pages/terms'
  get 'static_pages/privacy'
  root "home#index"
  get 'terms_of_service', to: 'static_pages#terms_of_service'

  resources :fonts, only: %i[index show]

  # 静的ページ
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'

  # ユーザー登録関連
  resources :users, only: %i[new create]

  # ログイン・ログアウト関連
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end

Rails.application.routes.draw do
  # ルートページ
  root "fonts#index"

  # 静的ページ
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'

  # フォント関連
  resources :fonts, only: %i[index show]

  # ユーザー登録関連
  resources :users, only: %i[new create]

  # ログイン・ログアウト関連
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  # パスワードリセット関連
  resources :password_resets, only: [:new, :create, :edit, :update]

  # メールアドレス変更関連
  resource :email_change, only: [:edit, :update] do
    member do
      get :confirm
    end
  end

  # 開発環境用
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

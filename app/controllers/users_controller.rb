class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # 登録後は自動ログインして、元のページまたはトップページにリダイレクト
      auto_login(@user)
      redirect_back_or_to(root_path, notice: 'ユーザー登録が完了しました')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # マイページ：お気に入りフォント一覧表示
    @favorite_fonts = current_user.favorite_fonts.includes(:font)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
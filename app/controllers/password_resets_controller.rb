class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  before_action :load_user_from_token, only: [:edit, :update]

  def new
  end

  def create
    Rails.logger.info "=== PASSWORD RESET DEBUG ==="
    Rails.logger.info "GMAIL_USERNAME: #{ENV['GMAIL_USERNAME']}"
    Rails.logger.info "GMAIL_PASSWORD length: #{ENV['GMAIL_PASSWORD']&.length}"
    Rails.logger.info "GMAIL_PASSWORD first 4 chars: #{ENV['GMAIL_PASSWORD']&.first(4)}"
    Rails.logger.info "================================"
    # メールアドレスからユーザーを検索
    @user = User.find_by(email: params[:email])

    if @user.present?
      begin
        @user.deliver_reset_password_instructions!
      rescue => e
        Rails.logger.error "Password reset email failed: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
      end
    end

    # セキュリティのため、常に同じメッセージを表示
    redirect_to login_path, notice: 'パスワードリセットメールを送信しました'
  end

  def edit
  end

  def update
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.change_password(params[:user][:password])
      redirect_to login_path, notice: 'パスワードを更新しました'
    else
      flash.now[:alert] = 'パスワードの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def load_user_from_token
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    unless @user
      redirect_to login_path, alert: 'パスワードリセットのリンクが無効または期限切れです'
    end
  end
end

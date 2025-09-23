class TestController < ApplicationController

    skip_before_action :require_login

    # 本番環境でのみアクセス可能にする
    before_action :check_test_mode

    def send_test_email
    user = User.find_by(email: params[:email]) || User.first

    if user
    begin
        # 直接メール送信をテスト
        UserMailer.reset_password_email(user).deliver_now
        render json: {
        status: 'success',
        message: "Test email sent to #{user.email}",
        user_id: user.id
        }
    rescue => e
        render json: {
        status: 'error',
        message: e.message,
        error_class: e.class.name
        }
    end
    else
    render json: {
        status: 'error',
        message: 'User not found'
    }
    end
end

private

def check_test_mode
    # 本番環境でも一時的にテスト可能にする
    return if Rails.env.production? && params[:test_key] == 'my_debug_key_2025'
    return if Rails.env.development?

    render json: { error: 'Access denied' }, status: 403
end
end
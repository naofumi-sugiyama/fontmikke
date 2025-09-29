class EmailChangesController < ApplicationController
    before_action :require_login
  
    def edit
      # メールアドレス変更フォーム表示
    end
  
    def update
      new_email = email_params[:email]
      
      if valid_email?(new_email) && new_email != current_user.email
        # メールアドレス変更処理を実行
        current_user.request_email_change(new_email)
        redirect_to root_path, success: '新しいメールアドレスに確認メールを送信しました。'
      else
        flash.now[:danger] = 'メールアドレスが無効です。'
        render :edit, status: :unprocessable_entity
      end
    end
  
    def confirm
      token = params[:id]  # member routeなので:idで取得
      user = User.find_by(email_change_token: token)
      
      if user&.email_change_token_expires_at&.> Time.current
        # メールアドレス変更を確定
        old_email = user.email
        user.update!(
          email: user.pending_email,
          pending_email: nil,
          email_change_token: nil,
          email_change_token_expires_at: nil
        )
        
        # 変更完了通知メールを旧メールアドレスに送信
        UserMailer.email_changed_notification(old_email, user.email).deliver_now
        
        redirect_to root_path, success: 'メールアドレスを変更しました。'
      else
        redirect_to root_path, danger: '無効なリンクまたは期限切れです。'
      end
    end
  
    private

    def email_params
      params.require(:email_change).permit(:email, :email_confirmation)
    end

    def valid_email?(email)
      email.present? && email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
    end
end
class UserMailer < ApplicationMailer
  # 既存のパスワードリセットメソッド
  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(user.reset_password_token)
    mail(to: @user.email, subject: 'パスワードリセット')
  end

  # メールアドレス変更確認メール（新しいメールアドレス宛）
  def email_change_confirmation(user)
    @user = user
    @new_email = user.pending_email
    @confirmation_url = confirm_email_change_url(user.email_change_token)
    @expires_at = user.email_change_token_expires_at.strftime("%Y年%m月%d日 %H:%M")

    mail(
      to: @new_email,  # 新しいメールアドレスに送信
      subject: 'メールアドレス変更の確認'
    )
  end

  # メールアドレス変更完了通知メール（旧メールアドレス宛）
  def email_changed_notification(old_email, new_email)
    @old_email = old_email
    @new_email = new_email
    @changed_at = Time.current.strftime("%Y年%m月%d日 %H:%M")

    mail(
      to: old_email,  # 旧メールアドレスに送信
      subject: 'メールアドレスが変更されました'
    )
  end
end
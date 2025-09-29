class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true

  def request_email_change(new_email)
    # 新しいメールアドレスのバリデーション
    return false if new_email.blank?
    return false unless valid_email_format?(new_email)

    # 既存ユーザーとの重複チェック
    return false if User.exists?(email: new_email)

    # 現在のメールアドレスと同じかチェック
    return false if email == new_email

    # トークン生成と保存
    token = generate_email_change_token
    update!(
      pending_email: new_email,
      email_change_token: token,
      email_change_token_expires_at: 24.hours.from_now
    )

    # 確認メール送信
    UserMailer.email_change_confirmation(self).deliver_now
    true
  rescue => e
    Rails.logger.error "メールアドレス変更申請エラー: #{e.message}"
    false
  end

  private

  def valid_email_format?(email)
    email.match?(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
  end

  def generate_email_change_token
    loop do
      token = SecureRandom.urlsafe_base64(32)
      break token unless User.exists?(email_change_token: token)
    end
  end
end
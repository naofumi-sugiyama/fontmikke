class HomeController < ApplicationController
  def index
    @fonts = Font.all

  # デバッグ用ログ出力
  Rails.logger.info "=== Font count: #{@fonts.count} ==="

  # 画面上にも表示（一時的）
  flash.now[:notice] = "フォント数: #{@fonts.count}件"
  end
end

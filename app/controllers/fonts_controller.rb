class FontsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @fonts = Font.all
  end

  def show
    @font = Font.find(params[:id])  # 特定のフォントを取得
    @preview_text = params[:preview_text] || 'こんにちは'
  end
end

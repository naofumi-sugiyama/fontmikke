class FontsController < ApplicationController
  def show
    @font = Font.find(params[:id])  # 特定のフォントを取得
    @preview_text = params[:preview_text] || 'こんにちは'
  end
end

class FontsController < ApplicationController
  def index
    @fonts = Font.all  # 全フォントを取得
  end

  def show
    @font = Font.find(params[:id])  # 特定のフォントを取得
  end
end

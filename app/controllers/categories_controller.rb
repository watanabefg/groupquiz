#encoding:UTF-8
class CategoriesController < ApplicationController
  def new
    @category = Category.new
    @title = "カテゴリーの作成|Groupquiz:クイズで楽しく情報共有"
  end

  def create
    @category = Category.new(params[:category])
    if @category.save then
      flash[:success] = "登録に成功しました"
      redirect_to @category
    end
  end

  def show
    @category = Category.find(params[:id])
    @title = @category.name
  end

end

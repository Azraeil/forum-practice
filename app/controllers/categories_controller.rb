class CategoriesController < ApplicationController
  def show
    # 顯示文章分類按鈕
    @categories = Category.all

    # 找出指定的分類
    @category = Category.find(params[:id])

    # 找出該分類底下的文章
    @posts = @category.posts
  end
end

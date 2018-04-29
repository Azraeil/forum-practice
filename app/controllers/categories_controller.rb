class CategoriesController < ApplicationController
  def show
    # 顯示文章分類按鈕
    @categories = Category.all

    # 找出指定的分類
    @category = Category.find(params[:id])

    # 找出該分類底下的文章
    @ransack = @category.posts.where(status: "publish").ransack(params[:q])

    @posts = @ransack.result(distinct: true).page(params[:page]).per(20)
  end
end

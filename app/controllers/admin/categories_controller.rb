class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.all

    # 根據有無傳入 params[:id] 來判斷實例變數的形態
    if params[:id]
      # edit category
      @category = Category.find(params[:id])
    else
      # new category
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_params)
    puts category_params
    if @category.save
      flash[:notice] = "Category was successfully created!"
      redirect_to admin_categories_path
    else
      flash[:alert] = "Category was failed to create."
      @categories = Category.all
      render :index
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end

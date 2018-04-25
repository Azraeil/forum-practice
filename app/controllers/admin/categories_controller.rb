class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:update, :destroy]

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

  def update
    # set_category

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Category data was successfully updated."
    else
      flash.now[:alert] = "Category was failed to update!"
      @categories = Category.all
      render :index
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Category was successfully deleted."
    else
      flash[:alert] = @category.errors.full_messages.to_sentence
    end

    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end

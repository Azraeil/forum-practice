class UsersController < ApplicationController
  before_action :set_user
  def show
    # set_user

    @posts = @user.posts.where(status: "publish")
  end

  def edit
    if current_user == @user
      # allow to edit

    else
      redirect_to user_path(@user.id)
    end
  end

  def update
    # set_user
    if @user.update(user_params)
      flash[:notice] = "User data was successfully updated."
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "User was failed to update!"
      render :edit
    end
  end

  # "My Draft" page
  def draft
    # set_user

    if current_user == @user
      @posts = @user.posts.where(status: "draft")
    end
  end

  def comment
    # set_user

    @comments = @user.comments
  end

  private
  def set_user
    @user = User.find(params[:id])
    return @user
  end

  # for strong parameters
  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end

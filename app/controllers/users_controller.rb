class UsersController < ApplicationController
  before_action :set_user
  def show
    # before action set_user
  end

  def edit
    if current_user == @user
      # allow to edit

    else
      redirect_to user_path(@user.id)
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
    return @user
  end
end

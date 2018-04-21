class UsersController < ApplicationController
  before_action :set_user
  def show
    # before action set_user
  end

  private
  def set_user
    @user = User.find(params[:id])
    return @user
  end
end

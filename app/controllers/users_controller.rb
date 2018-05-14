class UsersController < ApplicationController
  before_action :set_user, except: [:friend_accept, :friend_ignore]

  def show
    # set_user

    @posts = @user.posts.where(status: "publish").order(id: :desc)
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
      @posts = @user.posts.where(status: "draft").order(id: :desc)
    end
  end

  def comment
    # set_user

    @comments = @user.comments
  end

  def collect
    # set_user

    @collects = @user.collects
  end

  def friend_request
    # set_user

    if current_user != @user
      # 建立好友邀請
      @friend_request = Friendship.new(
        user_id: current_user.id,
        friend_id: @user.id
      )

      @friend_request.save
    end

  end

  def friend_accept
    @friend_request = Friendship.find(params[:id])

    @friend_request.status = "accept"
    @friend_request.save
  end

  def friend_ignore
    @friend_request = Friendship.find(params[:id])

    @friend_request.status = "ignore"
    @friend_request.save
  end

  def friend
    # set_user

    # 來自其他使用者的好友邀請，好友發起人： user_id
    @wait_for_responses = Friendship.where(user_id: @user.id, status: "wait")

    @requests = Friendship.where(friend_id: @user.id, status: "wait")

    @friendships = Friendship.where(user_id: @user.id, status: "accept").or(Friendship.where(friend_id: @user.id, status: "accept"))
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

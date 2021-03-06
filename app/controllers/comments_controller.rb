class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy, :edit, :update]

  def create
    @post = Post.find(params[:post_id])

    # 權限檢查
    permission_check(@post, current_user)

    if @comment = Comment.create!(
      user_id: current_user.id,
      post_id: params[:post_id],
      content: comment_params[:content])
      flash[:notice] = "Comment was created successfully."
    else
      flash[:alert] = "Comment was failed to create."
    end

    redirect_to post_path(@post.id)
  end

  def destroy
    # set_comment
    @post = Post.find(params[:post_id])

    # 只有管理員或作者才能刪除回覆
    if current_user.role == "Admin" || current_user == @comment.user
      if @comment.destroy
        flash[:notice] = "Comment was successfully deleted."
        redirect_back(fallback_location: post_path(@post.id))
      else
        flash.now[:alert] = "Comment was failed to delete!"
        redirect_back(fallback_location: post_path(@post.id))
      end
    end
  end

  def edit
    # set_comment
    if current_user == @comment.user
      @post = Post.find(params[:post_id])

      @comments = @post.comments
    end
  end

  def update
    @post = Post.find(params[:post_id])

    if @comment = Comment.update(
      user_id: current_user.id,
      post_id: params[:post_id],
      content: comment_params[:content])
      flash[:notice] = "Comment was updated successfully."
    else
      flash[:alert] = "Comment was failed to update."
    end

    redirect_to post_path(@post.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def permission_check(post, current_user)
    if post.who_can_see == "All" ||
      post.who_can_see == "Friend" && current_user.friend?(post.user) == "accept" ||
      post.user == current_user
      # allow to access
    else
      redirect_back(fallback_location: root_path)
    end
  end
end

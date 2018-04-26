class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    if @comment = Comment.create!(user_id: current_user.id, post_id: params[:post_id], content: comment_params[:content])
      flash[:notice] = "Comment was created successfully."
    else
      flash[:alert] = "Comment was failed to create."
    end

    redirect_to post_path(@post.id)
  end

  def destroy

  end

  def edit

  end

  def update

  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end

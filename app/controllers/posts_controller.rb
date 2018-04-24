class PostsController < ApplicationController
  # 依需求，瀏覽論壇首頁時，不用登入
  skip_before_action :authenticate_user!, only: [:index]

  before_action :set_post, only: [:show]

  def index
    @posts = Post.last(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Post was created successfully."
      redirect_to post_url(@post.id)
    else
      flash[:alert] = "Post was failed to create."
      render :new
    end
  end

  def show

  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :file, :who_can_see)
  end
end

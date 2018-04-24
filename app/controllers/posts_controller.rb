class PostsController < ApplicationController
  # 依需求，瀏覽論壇首頁時，不用登入
  skip_before_action :authenticate_user!, only: [:index]

  before_action :set_post, only: [:show, :edit, :update]

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
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "Post was failed to create."
      render :new
    end
  end

  def show

  end

  def edit
    # set_post

    #dev 只有作者才能編輯文章

  end

  def update
    # set_post

    if @post.update(post_params)
      flash[:notice] = "Post data was successfully updated."
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "Post was failed to update!"
      render :edit
    end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :file, :who_can_see)
  end
end

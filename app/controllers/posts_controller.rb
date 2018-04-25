class PostsController < ApplicationController
  # 依需求，瀏覽論壇首頁時，不用登入
  skip_before_action :authenticate_user!, only: [:index]

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.last(10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    set_post_status()

    if @post.save
      flash[:notice] = "Post was created successfully."
      redirect_by_status()
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

    set_post_status()

    if @post.update(post_params)
      flash[:notice] = "Post data was successfully updated."
      redirect_by_status()
    else
      flash.now[:alert] = "Post was failed to update!"
      render :edit
    end
  end

  def destroy
    # dev 只有作者才能刪除文章
    # set_post

    if @post.destroy
      flash[:notice] = "Post was successfully deleted."
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = "Post was failed to delete!"
      redirect_to post_path(@post.id)
    end
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :file, :who_can_see, :category_id)
  end

  def post_status_params
    params.require(:commit)
  end

  def set_post_status
    if post_status_params == "Submit"
      @post.status = "publish"
    else
      @post.status = "draft"
    end
  end

  def redirect_by_status
    if @post.status == "publish"
      # 文章發佈就導向到 posts#show
      redirect_to post_path(@post.id)
    else
      # 文章存成草稿就導向到 users#draft
      # dev 先導向到 users#show
      redirect_to user_path(current_user.id)
    end
  end
end

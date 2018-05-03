class PostsController < ApplicationController
  # 依需求，瀏覽論壇首頁時，不用登入
  skip_before_action :authenticate_user!, only: [:index]

  before_action :set_post, only: [:show, :edit, :update, :destroy, :collect, :uncollect]

  def index
    # 顯示文章分類按鈕
    @categories = Category.all

    # 透過 ransack 排序跟搜尋
    @ransack = Post.where(status: "publish").order(id: :desc).ransack(params[:q])

    # dev 待處理，文章觀看權限的部分
    @posts = @ransack.result(distinct: true).page(params[:page]).per(20)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    set_post_status()
    @post.user_id = current_user.id

    if @post.save
      flash[:notice] = "Post was created successfully."
      redirect_by_status()
    else
      flash[:alert] = "Post was failed to create."
      render :new
    end
  end

  def show
    # set_post

    # 觀看權限檢查
    permission_check(@post, current_user)

    # 顯示回覆
    @comments = @post.comments.page(params[:page]).per(20)

    # 新增回覆
    @comment = Comment.new

    # 增加瀏覽次數
    @post.increase_visit
  end

  def edit
    # set_post

    # 只有作者才能編輯文章
    if current_user == @post.user
      # allow to edit

    else
      redirect_to post_path(@post.id)
    end
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
    # set_post

    # 只有管理員或作者才能刪除文章
    if current_user.role == "Admin" || current_user == @post.user
      if @post.destroy
        flash[:notice] = "Post was successfully deleted."
        redirect_to user_path(current_user.id)
      else
        flash.now[:alert] = "Post was failed to delete!"
        redirect_to post_path(@post.id)
      end
    end
  end

  def collect
    # set_post

    @collect = Collect.create!(
      user_id: current_user.id,
      post_id: @post.id
    )

    redirect_back(fallback_location: post_path(@post.id))
  end

  def uncollect
    # set_post

    puts current_user
    puts @post

    collect = Collect.where(
      user_id: current_user.id,
      post_id: @post.id
    )

    collect.destroy_all

    redirect_back(fallback_location: post_path(@post.id))
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :file, :who_can_see, :category_ids => [])
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
      redirect_to draft_user_path(current_user.id)
    end
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

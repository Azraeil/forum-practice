class PostsController < ApplicationController
  # 依需求，瀏覽論壇首頁時，不用登入
  skip_before_action :authenticate_user!, only: [:index]

  before_action :set_post, only: [:create]

  def index
    @posts = Post.last(10)
  end

  def new
    @post = Post.new
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end
end

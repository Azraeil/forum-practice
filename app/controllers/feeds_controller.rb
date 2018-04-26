class FeedsController < ApplicationController
  def index
    @user_count = User.count
    @post_count = Post.count
    @comment_count = Comment.count

    # 聲量最大的使用者 top 10（最多回覆數）
    @users = User.order(comments_count: :desc).first(10)

    # 最熱門的文章 top 10（最多人回覆）
    @posts = Post.order(comments_count: :desc).first(10)

  end
end

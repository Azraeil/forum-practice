class Api::V1::PostsController < ApiController
  # 加入認證程序，使用者需登入才能瀏覽網站
  # before_action :authenticate_user!
  # skip_before_action :index
  def index
    @posts = Post.all

    render json: {
      data: @posts.map do |post|
        {
          id: post.id,
          title: post.title,
          date: post.created_at.strftime("%Y-%m-%d"),
          content: post.content,
          file: post.file,
          who_can_see: post.who_can_see,
          user_id: post.user_id,
          category_id: post.category_id
        }
      end
    }
  end

  def show
    @post = Post.find(params[:id])

    if !@post
      render json: {
        message: "Cannot find the post !",
        status: 400
      }
    else
      render json: {
          id: @post.id,
          title: @post.title,
          date: @post.created_at.strftime("%Y-%m-%d"),
          content: @post.content,
          file: @post.file,
          who_can_see: post.who_can_see,
          user_id: @post.user_id,
          category_id: @post.category_id
        }
    end
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: {
        message: "Post was created successfully!",
        result: @post
      }
    else
      render json: {
        error: @post.errors
      }
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      render json: {
        message: "Post was updated successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    render json: {
      message: "Post destroy seccessfully!"
    }
  end

  private
  def post_params
    params.permit(:title, :content, :file, :who_can_see, :category_id, :user_id)
  end
end

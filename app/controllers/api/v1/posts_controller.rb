class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.order(created_at: :desc)
    render json: @posts
  end

  def show
    @user = User.new
    @post = Post.find params[:id]
    @comment = Comment.new
    render json: @post
  end

  def create
    # post_params  = params.require(:post).permit([:title, :body])
    @post       = Post.new post_params
    @post.user = current_user

    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end
end

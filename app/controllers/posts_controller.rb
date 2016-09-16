class PostsController < ApplicationController

before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

POSTS_PER_PAGE=5

  def new
      @post = Post.new
    end

    def create
      # post_params  = params.require(:post).permit([:title, :body])
      @post       = Post.new post_params
      @post.user = current_user

      if @post.save
        if @post.tweet_it
        client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET"]
        config.access_token        = current_user.twitter_token
        config.access_token_secret = current_user.twitter_secret
      end
        client.update "#{@post.title} #{post_url(@post)}"
      end

        redirect_to post_path(@post)
      else
        render :new
      end
    end

    def show
      @user = User.new
      @post = Post.find params[:id]
      @comment = Comment.new
    end

    def index
      @posts = Post.order(created_at: :desc).page(params[:page]).per(POSTS_PER_PAGE)
    end

    def destroy
      # post = Post.find params[:id]
      # post.destroy
      @post.destroy
      redirect_to posts_path
    end

    def edit
      @post = Post.find params[:id]
    end

    def update
      @post = Post.find params[:id]
      if @post.update post_params
        redirect_to post_path(@post)
      else
        render :edit
      end
    end

    private
    def post_params
    params.require(:post).permit(:title, :body, :tweet_it)
    end

end

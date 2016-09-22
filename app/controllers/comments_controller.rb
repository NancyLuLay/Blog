class CommentsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

  def new
      @comment = Comment.new
    end

  def create
    puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    @comment = Comment.new

    p @comment



    p "current user method: "
    p current_user
    @comment.user = current_user
    p "current user: "
    p @comment.user
    @comment = Comment.new params.require(:comment).permit(:title, :body)
    @post = Post.find params[:post_id]
    @comment.post = @post

    respond_to do |format|
      if @comment.save
        format.html {redirect_to post_path(@post), notice: "Comment created" }
        format.js { render :create_success }
      else
        flash[:alert] = "Please fix errors below"
        format.html {render "/posts/show"}
        format.js { render :create_failure }
      end
    end

  end

  def destroy
    post = Post.find params[:post_id]
    comment = Comment.find params[:id]
    comment.destroy
    redirect_to post_path(post), notice: "Comment deleted"
  end

  def show
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
  end

  def index
    @comments = Comment.order(created_at: :desc)
  end


  def edit
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
  end

  def update
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    if @comment.update comment_params
      redirect_to post_comment_path(@post.id)
    else
      render :edit
    end
  end

  private
  def comment_params
  params.require(:comment).permit(:title, :body)
  end

end

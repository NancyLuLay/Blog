class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find params[:post_id]
    favourite = Favourite.new user: current_user, post: post
    if !(can? :favourite, post)
      redirect_to root_path, alert: "access denied"
    elsif favourite.save
      redirect_to post_path(post), notice: "You've favourited this post"
    else
      redirect_to post_path(post), alert: favourite.errors.full_messages.join(", ")
    end
  end


  def destroy
    post = Post.find params[:post_id]
    favourite = Favourite.find params[:id]
    if can? :destroy, favourite
      favourite.destroy
    redirect_to post_path(post), notice: "Favourite removed!"
    else
    redirect_to root_path, alert: "access denied!"
    end
  end


end

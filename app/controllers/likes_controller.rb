class LikesController < ApplicationController
  before_action :find_post, only: [:create]
  before_action :find_like, only: [:destroy]

  def create
    @post.likes.create(user_id: current_user.id)
    redirect_to post_path(@post)
    authorize @post
  end

  def destroy
    @like = Like.find(params[:id])
    authorize @like
    @like.destroy
    redirect_to posts_path, status: :see_other
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
    @like = Like.find(params[:id])
  end
end

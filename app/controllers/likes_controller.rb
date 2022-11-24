class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    @post.likes.create(user_id: current_user.id)

    redirect_to post_path(@post)
    authorize @post
  end

  def destroy
    @like.destroy

    redirect_to post_path(@post)
    authorize @like
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
    @like = @post.likes.find(params[:id])
  end
  # def create
  #   post = Post.find(params[:post_id])
  #   like = Like.new
  #   like.user = current_user
  #   like.post = post
  #   like.save!
  #   redirect_to posts_path(anchor: "post-#{post.id}")
  #   authorize @like
  # end

  # def destroy
  #   post = Post.find(params[:id].to_i)
  #   like = post.likes.where(user_id:current_user.id)
  #   like.first.destroy
  #   redirect_to posts_path(anchor: "post-#{post.id}")
  #   authorize @like
  # end
end

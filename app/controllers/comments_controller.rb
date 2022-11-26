class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments
    @comment = Comment.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @comment
    authorize @post
  end

  def edit
    authorize @comment
  end

  def update
    @post = Post.find(params[:post_id])
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @comment
    authorize @post
  end

  def destroy
    @comment.destroy
    authorize @comment
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end

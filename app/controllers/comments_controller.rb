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
    if @comment.save
      redirect_to comment_path(@comment)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @comment
  end

  def edit
    authorize @comment
  end

  def update
    if @comment.update(comment_params)
      redirect_to comment_path(@comment)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @comment
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
    params.require(:comment).permit(:content)
  end
end

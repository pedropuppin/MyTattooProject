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
    authorize @comment
    authorize @post
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post) }
        format.json # Follow the classic Rails flow and look for a create.json view
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json # Follow the classic Rails flow and look for a create.json view
      end
    end
  end

  def edit
    authorize @comment
  end

  def update
    @post = Post.find(params[:post_id])
    authorize @comment
    authorize @post
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
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

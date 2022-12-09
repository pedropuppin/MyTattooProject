class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]
  after_action :verify_policy_scoped, only: :index

  def index
    @user = current_user
    @comment = Comment.new
    authorize @comment, policy_class: CommentPolicy

    if params[:query].present?
      skip_policy_scope
      collection_posts = []
      collection_posts << Post.search_by_tag(params[:query])
      collection_posts << Post.search_by_content(params[:query])
      User.search_by_user(params[:query]).each { |user| collection_posts << user.posts }
      User.search_by_address(params[:query]).each { |user| collection_posts << user.posts }
      @posts = []
      collection_posts.each do |collection_post|
        collection_post.each do |post|
          @posts << post
        end
      end
      @posts
    else
      @posts = policy_scope(Post).order(created_at: :desc)
    end
  end

  def show
    authorize @post
    @comment = Comment.new
    authorize @comment, policy_class: CommentPolicy
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    authorize @post

    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(params.require(:post).permit(:content))
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :photo, :tag_list)
  end
end

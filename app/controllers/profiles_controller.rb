class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[post_user_profile show]

  def show
    @user = User.find(params[:user_id])
    authorize @user
    @posts = policy_scope(Post).where(user: @user)
  end
end

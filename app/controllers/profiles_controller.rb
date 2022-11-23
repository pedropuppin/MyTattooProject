class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[post_user_profile show]
  def show
    @user = current_user
    authorize @user
  end

  def post_user_profile
    @user = User.find(params[:user_id])
    authorize @user
  end
end

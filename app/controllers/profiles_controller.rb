class ProfilesController < ApplicationController
  def show
    @user = current_user
    authorize @user
  end

  def post_user_profile
    @user = User.find(params[:user_id])
    authorize @user
  end
end

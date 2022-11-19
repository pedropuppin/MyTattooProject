class ProfilesController < ApplicationController
  def show
    @user = current_user
    authorize @user
  end

  def set_full_name
    @user = current_user
    [@user.first_name, @user.last_name].join(' ')
  end
end

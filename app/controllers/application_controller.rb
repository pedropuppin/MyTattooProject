class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :dispatch_user
  add_flash_types :info, :notice

  def dispatch_user
    return unless current_user && request.get?

    path = new_addresses_path if current_user.role == "artist" && current_user.address.nil?

    redirect_to path unless path.nil? || path == request.path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone role username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name phone role username])
  end
end

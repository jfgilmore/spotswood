class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Add avatar_attachment retrieval to devise current_user saves time in views &
  # ActiveRecord as avatar is present in every view
  def current_user
    @current_user ||= super && User.eager_load(
      avatar_attachment: :blob, interactions: :user
    ).find(@current_user.id)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name coc role])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name avatar role])
  end
end

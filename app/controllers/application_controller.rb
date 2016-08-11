class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_notifications

  def current_notifications
    @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).includes({comment: [:blog]})
    @notifications_count = Notification.where(recipient_id: current_user).order(created_at: :desc).unread.count
  end

  PERMISSIBLE_ATTRIBUTES = %i(name avatar avatar_cache)

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :name
  #  devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  #  devise_parameter_sanitizer.for(:account_update) << :profile
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up).push(PERMISSIBLE_ATTRIBUTES)
      devise_parameter_sanitizer.for(:account_update).push(PERMISSIBLE_ATTRIBUTES)
    end

end

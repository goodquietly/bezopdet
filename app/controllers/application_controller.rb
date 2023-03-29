class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name birthday])
  end

  private

  def record_not_found
    return user_not_authorized unless current_user.present?

    redirect_to root_path, alert: 'Страницы с данным ID не существует. Выберите другой ID.'
  end

  def user_not_authorized
    flash[:alert] = 'Вам не разрешено выполнять это действие.'

    if current_user.present?
      redirect_to(request.referrer || root_path)
    else
      redirect_to(new_user_session_path)
    end
  end
end

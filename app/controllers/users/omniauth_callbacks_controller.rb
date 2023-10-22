class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth(auth)
    if user.persisted?
      user.update(access_token:    auth.credentials.token,
                  expires_at:      auth.credentials.expires_at,
                  refresh_token:   auth.credentials.refresh_token,
                  last_sign_in_by: auth.provider)
      sign_out_all_scopes
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      session['devise.google_data'] = auth.except('extra')
      redirect_to new_user_registration_url, alert: user.errors.full_messages.join("\n")
    end
  end

  def failure
    redirect_to root_path
  end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  private

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end

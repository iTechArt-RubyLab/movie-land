class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization
  include ActionController::MimeResponds

  before_action :configure_permitted_parameters, if: :devise_controller?
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :null_session, only: -> { request.format.json? }
  include Errors::ErrorHandler

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name surname username birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name surname username birthday])
  end
end

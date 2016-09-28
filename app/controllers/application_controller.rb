class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Add parameters to devise's params filter
  before_action :devise_permitted_params, if: :devise_controller?

  helper ApplicationHelper


  def devise_permitted_params
    devise_parameter_sanitizer.for(:sign_up) << :subdomain
  end
end

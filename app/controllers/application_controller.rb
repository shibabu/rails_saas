class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Add parameters to devise's params filter
  before_action :devise_permitted_params, if: :devise_controller?

  # Make actionmailer host subdomain-aware
  before_action :mailer_host_subdomain

  helper ApplicationHelper

  rescue_from CanCan::AccessDenied do
    redirect_to root_url, alert: 'Unauthorized Access'
  end



  protected

  def devise_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:subdomain])
  end

  def mailer_host_subdomain
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def authenticate_inviter!
    redirect_to(root_url, alert: 'Unauthorized Access') unless current_user.has_role? :app_admin
  end
end

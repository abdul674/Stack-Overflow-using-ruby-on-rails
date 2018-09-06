class ApplicationController < ActionController::Base
	include ApplicationHelper
	
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!, except: :index
	
	rescue_from CanCan::AccessDenied, 
							ActiveRecord::RecordNotFound do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

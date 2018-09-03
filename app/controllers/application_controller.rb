class ApplicationController < ActionController::Base
	include SessionsHelper

	before_action :require_login
	skip_before_action :require_login, only: [:index]

	# GET  '/'
	def index
		respond_to do |format|
			format.html { render 'static_pages/home' }
		end
	end

	private

	def require_login
    unless logged_in?
      flash[:warning] = "You must be logged in to access this page."
      redirect_to login_url
    end
  end

end

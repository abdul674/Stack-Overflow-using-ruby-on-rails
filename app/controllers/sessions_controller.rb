class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  # GET  '/login'
  def new
    respond_to do |format|
    	format.html { redirect_to current_user if logged_in? }
    end
	end

  # POST  '/login'
  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	
    respond_to do |format|
      format.html do
        if user.present? && user.authenticate(params[:session][:password])
          log_in(user)
          redirect_to root_url
        else
          flash[:danger] = "Invalid email or password."
        end
      end
    end
  end

  # DELETE  '/logout'
  def destroy
  	session.delete(:user_id) if logged_in?

    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end
end


class UsersController < ApplicationController

	skip_before_action :require_login

	# GET  '/users/new'
  def new
  	@user = current_user

  	respond_to do |format|
	  	format.html do
	  		if @user.present?
	  			redirect_to @user
	  		else
	  			@user = User.new
	  		end
		  end
  	end

  end

  # GET  '/users'
	def index
		@users = User.all.paginate(page: params[:page])
		respond_to do |format|
			format.html
		end
	end  

	# POST  '/users'
  def create
  	@user = User.new(user_params)
  	if @user.valid? && @user.save
  		flash[:success] = "Account Created"
  		session[:user_id] = @user.id
  		redirect_to @user
  	else
  		flash[:warning] = "Account creation unsuccessful."
  		render 'new'
  	end
  end

  # GET  '/users/:id'
  def show
  	respond_to do |format|
  		format.html do
		  	@user = User.find_by(id: params[:id])
		  end
	  end
  end

  private

  def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

end

class UsersController < ApplicationController

	skip_before_action :authenticate_user!
	load_resource

	# GET '/users'
	def index
	end

	# GET '/users/new'
	def new
	end

	# POST '/users'
	def create
	end

	# GET '/users/:id/edit'
	def edit
	end

	# PUT   '/users/:id'
	# PATCH '/users/:id'
	def update
	end

	# DELETE '/users/:id'
	def destroy
	end

end

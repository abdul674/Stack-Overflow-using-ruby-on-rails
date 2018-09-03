class CategoriesController < ApplicationController
	
	# GET  '/categories'
	def index
		@categories = Category.group("tag").count("id")
	end

end

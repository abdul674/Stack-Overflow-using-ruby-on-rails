class CategoriesController < ApplicationController
	
	# GET  '/categories'
	def index
		@categories = Category.joins(:question_categories)
													.select('categories.*, count(category_id) as "tag_count"')
													.group(:category_id)

		respond_to do |format|
			format.html
		end
	end

end

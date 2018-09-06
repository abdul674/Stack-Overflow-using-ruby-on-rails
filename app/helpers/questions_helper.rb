module QuestionsHelper
	def title
		if params[:tag] == "all" || params[:tag].blank?
			"All Questions"
		elsif @questions.blank?
			"Sorry! No match found for [#{params[:tag]}]."
		elsif !@questions.first.categories.find_by(tag: params[:tag])
			"No questions with Catagory tagged [#{params[:tag]}], Showing answers containing [#{params[:tag]}]"
		else
			"Catagory tagged [#{params[:tag]}]"
		end
	end

	def count(questions)
		count = questions.count
		count.class == Integer ? count : count.count
	end
end

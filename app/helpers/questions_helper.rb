module QuestionsHelper
	def title
		if session[:tag].present?
			"Catagory tagged [#{session[:tag]}]"
		else
			"All Questions"
		end
	end

	def count(questions)
		count = questions.count
		count.class == Integer ? count : count.count
	end
end

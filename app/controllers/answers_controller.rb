class AnswersController < ApplicationController

	load_resource :question, only: [:accept, :create]
	load_resource :answer, through: :question, only: [:accept, :create]

	# POST  '/questions/:question_id/answers'
	def create
		if @answer.save
			flash[:success] = "Your answer is recorded successfuly."
		else
			flash[:warning] = "We are unable to record your answer at this moment please try again later."
		end

		respond_to do |format|
			format.html { redirect_to @question }
		end
	end

	# PATCH  'question/:question_id/answers/:id/accept'
	def accept
		if @answer.present? && @answer.accept
			flash[:success] = "Thank you for your feedback."
		else
			flash[:warning] = "You can not accept this answer"
		end

		respond_to do |format|
			format.html { redirect_to @question }
		end
	end

	private

	def answer_params
		params.require(:answer).permit(:content)
	end

end

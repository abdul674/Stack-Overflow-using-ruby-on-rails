class AnswersController < ApplicationController
	include Vote

	# POST  '/questions/:question_id/answers'
	def create
		answer = Answer.new(answer_params)
		answer.question_id = params[:question_id]

		if answer.save
			flash[:success] = "Your answer is recorded successfuly."
		else
			flash[:success] = "We are unable to record your answer at this moment please try again later."
		end

		respond_to do |format|
			format.html { redirect_to question_url(params[:question_id]) }
		end
	end

	# PATCH  'question/:question_id/answers/:answer_id/accept'
	def accept
		answer = Answer.find_by(id: params[:answer_id])
		answer.accept(params[:question_id])

		flash[:success] = "Thank you for your feedback."
		redirect_to question_path(answer.question_id)
	end

	# GET  '/answers/upvote/:answer_id'
  def upvote
  	update_vote(Answer, params[:answer_id], 1)
  end

  # GET  '/answers/downvote/:answer_id'
  def downvote
    update_vote(Answer, params[:answer_id], -1)
  end

	private

	def answer_params
		params.require(:answer).permit(:content)
	end

end

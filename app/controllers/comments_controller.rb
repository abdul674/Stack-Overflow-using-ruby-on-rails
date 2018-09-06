class CommentsController < ApplicationController

	load_resource :question
	load_resource :answer, through: :question
	load_and_authorize_resource :comment, only: [:destroy]
	load_and_authorize_resource :comment, through: [:question, :answer], only: :create

	# DELETE  'comments/:id'
	def destroy
		comment_id = @comment.id
		@comment.destroy

		respond_to do |format|
			format.html { redirect_to request.referer || login_url }
			format.js { render 'destroy', locals: { comment_id: comment_id } }
		end
	end

	# POST  '/questions/:question_id/comments'
	# POST  '/questions/:question_id/answers/:answer_id/comments/:id'
	def create
		content = params["content-#{@comment.commentable_type.downcase}-#{@comment.commentable_id}".to_sym]
		@comment.content = content

    if @comment.save
    	flash.now[:success] = "Thank you for your response"
    else
    	flash.now[:warning] = "Sorry your response can not be recorded."
    end

    respond_to do |format|
      format.html { redirect_to request.referer || login_url }
      format.js
    end
	end
end

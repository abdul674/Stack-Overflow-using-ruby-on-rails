class CommentsController < ApplicationController

	# DELETE  'comments/:id'
	def destroy
		comment = Comment.find_by(id: params[:id])
		comment_id = comment.id

		if comment.present? && is_user_valid?
			comment.destroy
		else
			flash[:warning] = "You can not delete this comment."
		end

		respond_to do |format|
			format.html { redirect_to request.referer || login_url }
			format.js { render 'destroy', locals: { comment_id: comment_id } }
		end
	end

	# POST  'comments'
	def create
		commentable = get_commentable
		
		if commentable.present?
			@class = commentable.class.to_s.downcase
	    content = params["content-#{@class}-#{commentable.id}".to_sym]
	    @comment = commentable.comments.build(user_id: current_user.id, content: content)
	  else
	  	flash[:warning] = "You can not comment on this post."
    end

    if @comment.save
    	flash[:success] = "Thank you for your response"
    else
    	flash[:warning] = "Sorry your response can not be recorded."
    end

    respond_to do |format|
      format.html { redirect_to request.referer || login_url }
      format.js
    end
	end

	private

	def is_user_valid?
		logged_in? && current_user.id == comment.user_id
	end

	def get_commentable
		if params[:question_id].present?
			Question.find_by(id: params[:question_id])
		elsif params[:answer_id].present?
			Answer.find_by(id: params[:answer_id])
		else
			nil
		end
	end

end

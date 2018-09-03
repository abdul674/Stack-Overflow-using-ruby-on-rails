module Vote
  def update_vote(model, id, votes)
  	redirect_url = login_url
  	
    if logged_in?
  		element = model.find_by(id: id)
  		
      if element.present?
        begin
          element.update_columns(votes: element.votes + votes)
          flash.now[:success] = "Thank you for your feedback."
        rescue ActiveRecord::ActiveRecordError
          flash.now[:failure] = "Sorry! your feedback can not be recorded at the moment."
        end

  			redirect_url = question_answers_url(id)
  		else
        flash[:warning] = "Sorry you can not vote for the given item."
  			redirect_url = questions_url
  		end
		else
			flash[:warning] = "You must be logged in to cast a vote."
  	end

  	respond_to do |format|
			format.html { redirect_to redirect_url }
			format.js { render 'shared/vote', locals: { element: element } }
		end
  end
end
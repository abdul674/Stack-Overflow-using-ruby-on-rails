class VotesController < ApplicationController

	# PUT   '/votes/:id(.:format)'
	# PATCH '/votes/:id(.:format)'
	def update
		@vote = current_user.votes.find_by(voteable_id: params[:voteable_id], voteable_type: params[:voteable_type])

		if @vote.present? && @vote.value == params[:vote_value].to_i
			flash.now[:warning] = "You have already voted for this #{ @vote.voteable_type }"
		elsif @vote.present? && @vote.value == -params[:vote_value].to_i
			@vote.destroy
		else
			@vote = current_user.votes.create(voteable_id: params[:voteable_id], voteable_type: params[:voteable_type], value: params[:vote_value])
		end

		respond_to do |format|
			format.js { render 'shared/vote' }
		end
	end

end

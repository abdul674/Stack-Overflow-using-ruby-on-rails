module AnswersHelper
	def get_link_to_accept(answer)
		link_to "", 
						"/question/#{answer.question_id}/answers/#{answer.id}/accept", 
						id: "accept",
						method: :patch,
						class: "glyphicon glyphicon-ok #{answer.accepted? ? "accepted" : "not-accepted"}", 
						title: answer.accepted? ? "The correct answer to this question" : 
																			"Accept this answer as the answer to your question."
	end
end
class Answer < ApplicationRecord
	include Commentable
	include Voteable

	belongs_to :question
	has_one    :vote, as: :voteable, dependent: :destroy

	validates :content, presence: true

	def accept
		answer = self
		accepted_answer = Answer.where.not(id: answer.id).find_by(accepted: true, question_id: answer.question_id)

		transaction do 
			answer.accepted = !answer.accepted
			answer.save!
			
			if accepted_answer.present?
				accepted_answer.accepted = false
				accepted_answer.save!
			end
		end
	end
end

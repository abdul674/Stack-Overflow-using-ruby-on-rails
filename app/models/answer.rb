class Answer < ApplicationRecord
	include Commentable
	include Voteable

	belongs_to :question
	has_one    :vote, as: :voteable, dependent: :destroy

	validates :content, presence: true

	def accept
		accepted_answer = self.question.answers.where.not(id: self.id).find_by(accepted: true)

		self.transaction do 
			self.accepted = !self.accepted
			self.save!
			
			if accepted_answer.present?
				accepted_answer.accepted = false
				accepted_answer.save!
			else
				true
			end

		end
	end
end

class Answer < ApplicationRecord
	include Commentable

	belongs_to :question

	validates :content, presence: true

	def accept(question_id, answer_id)
		question = Question.find_by(id: question_id)
		
		accepted_answer = question.answers.find_by(accepted: true)

		answer.accepted = true
		if answer.save && accepted_answer.present?
			accepted_answer.accepted = false
			accepted_answer.save
		end
	end
end

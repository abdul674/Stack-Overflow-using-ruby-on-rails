class Question < ApplicationRecord
	include Commentable
	
	belongs_to :user
	has_many   :answers,           dependent: :destroy
	has_many   :categories,        dependent: :destroy

	validates  :title,   presence: true, length: { minimum: 20, maximum: 100 }
	validates  :content, presence: true, length: { minimum: 50 }

	def Question.sort_by(column = "id", sequence = "DESC")
		if column.present? && ActiveRecord::Base.connection.column_exists?(:questions, column.to_sym)
			order("#{column} #{sequence}")
		elsif column == "answers"
			joins("LEFT OUTER JOIN answers on questions.id = answers.question_id")
							.group("questions.id")
							.order("count(answers.id) #{sequence}")
		else
			all
		end
	end

	def Question.filter(tag = nil)
		if tag.present? && Category.find_by(tag: tag).present?
			joins(:categories).where({categories: {tag: tag}})
		else
			all
		end
	end

end
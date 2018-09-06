class Question < ApplicationRecord
	include Commentable
	include Voteable
	
	belongs_to :user
	has_many   :answers,             dependent: :destroy
	has_many   :question_categories, dependent: :destroy
	has_many   :categories, through: :question_categories

	validates  :title,   presence: true, length: { minimum: 20, maximum: 100 }
	validates  :content, presence: true, length: { minimum: 50 }

	def Question.sort_by_column(column = "id", direction = "DESC")
		if column == "answers"
			joins("LEFT OUTER JOIN answers ON questions.id = answers.question_id")
							.group("questions.id")
							.order("count(answers.id) #{direction}")
		elsif column == "votes"
			joins("LEFT OUTER JOIN votes ON questions.id = votes.voteable_id AND votes.voteable_type = 'Question'")
							.group("questions.id")
							.order("count(votes.id) #{direction}")
		else
			order("#{column} #{direction}")
		end
	end

	def Question.filter(tag = nil)
		if tag == "all" || tag.blank?
			all
		else
			questions = joins(:categories).where({ categories: { tag: tag } })

			if questions.blank?
				where("questions.content LIKE (?)", "%#{tag}%")
			else
				questions
			end
		end
	end

	def save_with_categories(categories)
		if !categories.present? || categories.count > 5
			errors.add(:tags, "count should be from 1 to 5.")
			false
		else
			transaction do
				save!
				
				categories.each do |category_id|
					question_categories.create!(category_id: category_id)
				end
			end
			true
		end
	end

end
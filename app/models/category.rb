class Category < ApplicationRecord
	has_many   :question_categories, dependent: :destroy
	has_many   :questions, through: :question_categories

	validates :tag, presence: true

end

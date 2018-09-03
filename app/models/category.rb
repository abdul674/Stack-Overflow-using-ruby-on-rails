class Category < ApplicationRecord
	belongs_to :questions

	validates :tag, presence: true
end

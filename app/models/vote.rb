class Vote < ApplicationRecord
	belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates  :value, numericality: { greater_than_or_equal_to: -1, less_than_or_equal_to: 1 }
end

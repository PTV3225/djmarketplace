class Review < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  validates :comment, presence: true
end

class Dj < ApplicationRecord
  belongs_to :genre
  belongs_to :user

  validates :name, presence: true, length: { maximum: 20 }
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :name, :description, uniqueness: true
end

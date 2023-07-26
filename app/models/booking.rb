class Booking < ApplicationRecord
  belongs_to :dj
  belongs_to :user

  validates :start_date, :end_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :start_date_is_before_end_date
  validate :date_cannot_be_in_the_past

  private

  def start_date_is_before_end_date
    return unless start_date.present? && end_date.present? && end_date < start_date

    errors.add(:end_date, "must be after the start date")
  end

  def date_cannot_be_in_the_past
    return unless start_date.present? && end_date.present? && (start_date < Date.today || end_date < Date.today)

    errors.add(:end_date, "can't be in the past")
  end
end

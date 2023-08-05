class Booking < ApplicationRecord
  belongs_to :dj
  belongs_to :user
  has_one :review

  validates :start_time, :end_time, :date, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :start_time_is_before_end_time
  validate :date_cannot_be_in_the_past





  private

  def start_time_is_before_end_time
    return unless start_time.present? && end_time.present? && end_time < start_time

    errors.add(:end_time, "must be after the start time")
  end

  def date_cannot_be_in_the_past
    return unless date.present? && date < Date.today

    errors.add(:date, "can't be in the past")
  end
end

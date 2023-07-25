class Booking < ApplicationRecord
  belongs_to :dj
  belongs_to :user
end

class Dj < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  belongs_to :genre
  belongs_to :user

  validates :name, presence: true, length: { maximum: 20 }
  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :name, uniqueness: true

  has_one_attached :photo

  validates :link, format: { with: /\Ahttps:\/\/soundcloud\.com\/.*\z/, message: "should be a SoundCloud link" }

  #PG SEARCH implementation
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name],
    associated_against: {
      genre: [:category]
    },
    using: {
      tsearch: { prefix: true }
    }

  private

  def extract_soundcloud_track_id
    if link.present? && link.include?("soundcloud.com")
      self.link = link.split("/").last # Extract the track ID from the link
    end
  end
end

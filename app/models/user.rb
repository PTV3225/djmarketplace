class User < ApplicationRecord
  has_many :djs
  has_many :bookings, foreign_key: :user_id

 # Incoming bookings: Bookings made for the DJs that the user has created
 has_many :created_dj_bookings, through: :djs, source: :bookings

 # Outgoing bookings: Bookings made by the user for other DJs
 has_many :outgoing_bookings, class_name: 'Booking', foreign_key: :user_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end

class ChangeBookingDatesToTimesAndDate < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :start_date, :date
    remove_column :bookings, :end_date, :date
    add_column :bookings, :start_time, :time
    add_column :bookings, :end_time, :time
    add_column :bookings, :date, :date
  end
end

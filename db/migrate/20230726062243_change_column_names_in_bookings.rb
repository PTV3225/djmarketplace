class ChangeColumnNamesInBookings < ActiveRecord::Migration[7.0]
  def change
    rename_column :bookings, :from, :start_date
    rename_column :bookings, :until, :end_date
  end
end

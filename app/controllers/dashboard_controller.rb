class DashboardController < ApplicationController
  def show

    @user = current_user
    @djs = @user.djs
    @incoming_bookings = @user.created_dj_bookings
    @outgoing_bookings = @user.outgoing_bookings


  end
end

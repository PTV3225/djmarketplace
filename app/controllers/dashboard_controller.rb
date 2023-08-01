class DashboardController < ApplicationController
  def show
    @user = current_user
    @djs = @user.djs
    @pending_bookings = @user.pending_bookings.includes(:dj)
  end
end

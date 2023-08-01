class BookingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @dj = Dj.find(params[:dj_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @dj = Dj.find(params[:dj_id])
    @booking.dj = @dj

    if @booking.save
      redirect_to @booking, notice: "Booking was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])

    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Booking was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking = Booking.find(params[:id])

    if @booking.destroy
      redirect_to bookings_path, notice: 'Booking was successfully deleted.'
    else
      redirect_to @booking, alert: 'Failed to delete booking.'
    end
  end




  def approve
    booking = Booking.find(params[:id])
    # Update the booking status to approved
    booking.update(status: 'approved')
    # Redirect back to the dashboard or show a success message
    redirect_to dashboard_path, notice: 'Booking approved successfully.'
  end

  def reject
    booking = Booking.find(params[:id])
    # Update the booking status to rejected
    booking.update(status: 'rejected')
    # Redirect back to the dashboard or show a success message
    redirect_to dashboard_path, notice: 'Booking rejected successfully.'
  end



  private
  def booking_params
    params.require(:booking).permit(:dj_id, :user_id, :start_time, :end_time, :date)
  end
end

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

    @dj = Dj.find(params[:dj_id])
    @booking = Booking.new(booking_params)
    @booking.dj = @dj
    @booking.user = current_user
    # @booking.status = :pending


    if @booking.save
   # Send email or notification to DJ's dashboard notifying about new booking request
      redirect_to dashboard_path, notice: "Booking request sent successfully."
    else
      render "djs/show" # or redirect back with an error message
    end
  end

  def approve
    @booking = Booking.find(params[:id])
    @booking.update(status: "approved")
    redirect_to dashboard_path, notice: "Booking approved successfully."
  end

  def reject
    @booking = Booking.find(params[:id])
    @booking.update(status: "rejected")
    redirect_to dashboard_path, notice: "Booking rejected successfully."
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

  private
  def booking_params
    params.require(:booking).permit(:dj_id, :user_id, :start_time, :end_time, :date, :status, :total_price)
  end
end

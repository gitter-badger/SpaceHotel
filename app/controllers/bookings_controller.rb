class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @bookings = Booking.all
    respond_with(@bookings)
  end

  def show
    respond_with(@booking)
  end

  def new
    @booking = Booking.new
    @room = Room.find(params[:room_id])
    @booking.room = @room
    @booking.save
    respond_with(@booking)
  end

  def edit
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.save
    respond_with(@booking)
  end

  def update
    @booking.update(booking_params)
    respond_with(@booking)
  end

  def destroy
    @booking.destroy
    respond_with(@booking)
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:arrival, :departure, :status_id)
    end
end

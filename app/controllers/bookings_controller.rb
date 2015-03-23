class BookingsController < ApplicationController

  before_action :set_room
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @bookings = @room.bookings
    respond_with(@room)
  end

  def show
    @room = Room.find(params[:room_id])
    respond_with(@room, @booking)
  end

  def new
    @booking = @room.bookings.build
    respond_with(@room, @booking)
  end

  def edit
  end

  def create
    @booking = @room.bookings.create(booking_params)
    @booking.user = current_user
    @booking.save
    respond_with(@room, @booking)
  end

  def update
    @booking.update(booking_params)
    respond_with(@room, @booking)
  end

  def destroy
    @booking.destroy
    respond_with(@room, @booking)
  end

  private

    def set_room
      @room = Room.find(params[:room_id])
    end

    def set_booking
      @booking = @room.bookings.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:arrival, :departure, :status_id)
    end
end

class BookingsController < ApplicationController

  before_action :set_room, except: [:index]
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @bookings = Booking.all
    respond_with(@bookings)
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
    if current_user
      @booking.user = current_user
    else
      generated_password = Devise.friendly_token.first(8)
      user = User.create!(email: params[:email], first_name: params[:first_name],
                          last_name: params[:last_name], :password => generated_password)
      @booking.user = user
      RegistrationMailer.welcome(user, generated_password).deliver
    end
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

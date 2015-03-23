class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @rooms = Room.all
    respond_with(@rooms)
  end

  def show
    respond_with(@room)
  end

  def new
    @room = Room.new
    respond_with(@room)
  end

  def edit
  end

  def create
    @room = Room.new(room_params)
    @room.save
    respond_with(@room)
  end

  def update
    @room.update(room_params)
    respond_with(@room)
  end

  def destroy
    @room.destroy
    respond_with(@room)
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name, :price, :image, :size, :description, :occupancy, :image, :specification_id)
    end
end

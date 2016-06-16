class RoomsController < ApplicationController

  before_action :confirm_logged_in

  def index
    @rooms= Room.sorted
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to(:controller=>"rooms", :action=>"index")
    else
      render "new"
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(room_params)
      flash[:notice] = "Room Got updated Successfully"
      redirect_to(:controller => "rooms", :action => "index")
    else
      render "edit"
    end
  end
  def delete
    @room = Room.find(params[:id])
  end
  def destroy
    Room.find(params[:id]).destroy
    flash[:notice] = "Room Got Deleted"
    redirect_to(:controller => "rooms", :action=>"index")
  end
  private
    def room_params
      params.require(:room).permit(:name, :location)
    end
end

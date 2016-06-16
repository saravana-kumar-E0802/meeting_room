class RoomResourceController < ApplicationController

  # before_action :get_room_id, :except => [:index, :new, :create]

  def index
   @room = Room.find(params[:id])
   @resources = @room.room_resources
   # @resource_array = Resource.where.not(:id => @resources.select("resource_id")).map{|resource| [resource.name, resource.id]}
  end

  def new
  	@room_resource = RoomResource.new

  	@room = Room.find(params[:id])
	@resources = @room.room_resources
	@resource_array = Resource.where.not(:id => @resources.select("resource_id")).map{|resource| [resource.name, resource.id]}
  end

  def create

  	@room_resource = RoomResource.new(room_resource_params)
  	@room_resource.room_id = params[:id].keys[0]

 	if @room_resource.save
 		flash[:notice] = "New Resource added to Room Successfully"
 		redirect_to(:controller => "room_resource", :action => "index", :id =>params[:id].keys[0])
 	else
 		render "new"
 	end
  end
  
  def edit

  	@room_resource = RoomResource.find(params[:id])

  	@room = @room_resource.room
	@resources = @room.room_resources
	@resource_array = Resource.where(["id not in (?) or id = ?", @resources.select("resource_id"), @room_resource.resource_id]).map{|resource| [resource.name, resource.id]}

  end

  def update
  	@room_resource = RoomResource.find(params[:id])

  	if @room_resource.update_attributes(room_resource_params)
  		flash[:notice] = "Resource details updated successfully"
 		redirect_to(:controller => "room_resource", :action => "index", :id =>@room_resource.room_id)
 	else
 		render "edit"
 	end
  end

  def destroy
  	room_id = RoomResource.find(params[:id]).room_id
  	RoomResource.find(params[:id]).destroy
  	flash[:notice] = "Resource successfully got detatched from the Room"
  	redirect_to(:controller => "room_resource", :action => "index", :id =>room_id)
  end


  def room_resource_params
  	params.require(:room_resource).permit(:room_id, :resource_id, :count)
  end

  # def get_room_id
  # 	@room_id = RoomResource.find(params[:id]).room_id
  # end
end

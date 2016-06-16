class ResourcesController < ApplicationController

  before_action :confirm_logged_in

  def index
    @resources = Resource.sorted
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      redirect_to :controller =>'resources', :action => 'index'
    else
      render 'new'
    end
  end
  def edit
    @resource = Resource.find(params[:id])
  end
  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(resource_params)
      flash[:notice] = 'Resource Got updated'
      redirect_to :controller => 'resources', :action => 'index'
    else
      render 'edit'
    end
  end

  def delete
    @resource = Resource.find(params[:id])
  end
  def destroy
    Resource.find(params[:id]).destroy
    flash[:notice] = "Resource got Deleted"
    redirect_to :controller => 'resources', :action => 'index'
  end
  private
    def resource_params
      params.require(:resource).permit(:name, :configurations, :ismultiple)
    end
end

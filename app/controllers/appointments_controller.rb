class AppointmentsController < ApplicationController

  before_action :find_user

  before_action :confirm_logged_in
  
  def index
    if (@user.permissions == "admin")
      @appointments = Appointment.all.sorted
    else
      @appointments = @user.appointments.sorted
    end
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user_id = User.find_by_email(params[:appointment][:user_id]).id

    if @appointment.save
      redirect_to(:action => "index")
    else
      render "new"
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @user = @appointment.user
  end

  def update

    @appointment = Appointment.find(params[:id])
    @user = @appointment.user
    params[:appointment][:user_id] = User.find_by_email(params[:appointment][:user_id]).id

    if @appointment.update_attributes(appointment_params)

      flash[:notice] = "Appointment Updated Successfully!"
      redirect_to(:controller=>"appointments", :action=>"index")

    else

      render "edit"

    end
  end


  def delete
    @appointment = Appointment.find(params[:id])
  end

  def destroy
    Appointment.find(params[:id]).destroy
    flash[:notice] = "Appointment Got Deleted Successfully!"
    redirect_to(:controller => "appointments", :action=>"index")
  end


  private
    def appointment_params
      params.require(:appointment).permit(:user_id, :room_id, :start_time, :end_time)
    end
    
    def find_user
      if session[:user_id]
        @user = User.find_by_email(session[:user_id])
      end
    end
end

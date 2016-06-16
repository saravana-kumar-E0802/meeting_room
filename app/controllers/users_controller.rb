class UsersController < ApplicationController

  before_action :confirm_logged_in

  def index
    @users = User.sorted
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "New user Created Successfully"
      redirect_to(:controller=>"users", :action=>"index")
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "User got updated successfully"
      redirect_to(:controller => "users", :action => "index")
    else
      render "edit"
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User got deleted"
    redirect_to(:controller => "users", :action => "index")
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :permissions)
    end
end

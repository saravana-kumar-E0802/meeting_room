class AccessController < ApplicationController

  def index
  	@user = User.find_by_email(session[:user_id])
  	if @user.permissions == "admin"
  		redirect_to(:action => "admin_index")
  	else
  		redirect_to(:action => "user_index")
  	end
  end

  def admin_index
  end

  def user_index
  end

  def login
  end

  def attempt_login
  	if params[:user_id].present? && params[:password].present?
  		user = User.find_by_email(params[:user_id])
  		if user
	  		genuine_user = user.authenticate(params[:password])
	  	end
  	end
  	if genuine_user
		session[:user_id] = params[:user_id]
		session[:password] = params[:password]
  		flash[:notice] = " Welcome " + user.to_s
  		redirect_to(:action => "index")
  	else
  		flash[:notice] = "Invalid Credentials"
  		redirect_to(:action => "login")
  	end
  end
  def logout
  	session[:user_id] =nil
  	session[:password] =nil
  	flash[:notice] = "You are Logged Out"
	redirect_to(:action => "login")
  end
end

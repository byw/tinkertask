class SessionController < ApplicationController

  def create
    if user = User.authenticate(params[:username], params[:password])
      session[:user_id] = user.id
      redirect_to lists_path
    else
      render :new
      flash[:login_error] = "Login failed."
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end
end
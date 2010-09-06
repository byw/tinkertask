class SessionController < ApplicationController
  
  def new
    if current_user
      redirect_to lists_path
    end
  end

  def create
    if user = User.authenticate(params[:username], params[:password])
      if params[:remember_me]
        
      end
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
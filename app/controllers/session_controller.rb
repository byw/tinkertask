class SessionController < ApplicationController
  def new
    if current_user
      redirect_to lists_path
    else
      flash[:login_error] = nil
    end
  end

  def create
    if user = User.authenticate(params[:username], params[:password])
      if params[:remember_me]
        user_id = user.id.to_s
        cookies[:remember_me_id] = {:value => user_id, :expires => 30.days.from_now}
        cookies[:remember_me_code] = {:value => user.cookie_code, :expires => 30.days.from_now}
      end
      session[:user_id] = user.id
      redirect_to lists_path
    else  
      flash[:login_error] = "Bad combo, no login for you"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    cookies.delete :remember_me_id if cookies[:remember_me_id]
    cookies.delete :remember_me_code if cookies[:remember_me_code]
    redirect_to "/"
  end
end
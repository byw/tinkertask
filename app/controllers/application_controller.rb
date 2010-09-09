# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  def current_user
    unless @current_user
      unless session[:user_id]
        if cookies[:remember_me_id] && cookies[:remember_me_code] && 
           (user = User.find(cookies[:remember_me_id])) && user.cookie_code == cookies[:remember_me_code]
          
          session[:user_id] = user.id
        end
      end
      @current_user = User.find(session[:user_id])
    end
    @current_user
  end
  
  protected
  
    def require_user
      unless current_user
        redirect_to new_session_path
      end
    end
end

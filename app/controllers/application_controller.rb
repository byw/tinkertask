# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  rescue_from MongoMapper::DocumentNotFound, :with => :render_404

  before_filter :clear_identity_map
  
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
    
    # filter params for mass assignment, in controller rather than model
    def self.filter_param(name, opts={})
      self.prepend_before_filter(opts.slice(:only, :except)) do |controller|
        if controller.params[name]
          controller.params[name].slice!(*opts[:allow]) if opts[:allow]
          controller.params[name].except!(*opts[:deny]) if opts[:deny]
        end
      end
    end
    
    def render_404
      render :file => "#{Rails.root}/public/404.html", :status => 404
    end
    
    def clear_identity_map
      # clear once per request
      MongoMapper::Plugins::IdentityMap.clear
    end
end

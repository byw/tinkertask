class UsersController < ApplicationController
  inherit_resources
  include InheritedResources::DSL
  before_filter :require_user, :except => [:new, :create]
#  before_filter {|c|c.render :text => c.action_name}
  
  create! do |success, failure|
    success.html do
      session[:user_id] = @user.id
      redirect_to lists_path
    end
    failure.html do
      render :new
    end
  end
  
  update! do |success|
    success.html {redirect_to lists_path}
  end
  
  protected
  
    def resource
      @user ||= current_user
    end
end
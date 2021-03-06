class UsersController < ApplicationController
  inherit_resources
  include InheritedResources::DSL
  before_filter :require_user, :except => [:new, :create]
#  before_filter {|c|c.render :text => c.action_name}
  filter_param :user, :allow => [:username, :password, :password_confirmation, :email]
  
  def new
    if params[:user]
      flash[:user] = params[:user]
      redirect_to new_user_path
    elsif flash[:user]
      params[:user] = flash[:user]
    end  
    build_resource
  end
  
  create! do |success, failure|
    success.html do
      session[:user_id] = @user.id
      redirect_to lists_path
    end
    failure.html do
      render :new
    end
  end
  
  update! do |success, failure|
    success.html {redirect_to lists_path}
    failure.html do
      render :edit
    end
  end
  
  protected
  
    def resource
      @user ||= current_user
    end
end
class UsersController < ApplicationController
  inherit_resources
  include InheritedResources::DSL
  
  create! do |success|
    success.html do
      session[:user_id] => @user.id
      redirect_to lists_path
    end
  end
end
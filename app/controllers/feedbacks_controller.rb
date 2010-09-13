class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end
  
  def create
    @feedback = Feedback.new
    @feedback.email = params[:feedback][:email] || (current_user && current_user.email)
    @feedback.body = params[:feedback][:body]
    if @feedback.valid?
      @feedback.deliver
      redirect_to "/"
    else
      render :new
    end
=begin    
    errors = {}
    if params[:feedback][:email] || (current_user && current_user.email)
      
      errors[:email] = "can't be blank"
      if params[:feedback][:body] && !params[:feedback][:body].blank?
        
      else
        
        render :new
      end
    else
      render :new
    end
=end
  end
end
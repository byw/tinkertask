class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
    @feedback.email = (current_user && current_user.email) || ''
  end
  
  def create
    @feedback = Feedback.new
    @feedback.email = params[:feedback][:email] # || (current_user && current_user.email)
    @feedback.body = params[:feedback][:body]
    if @feedback.valid?
      @feedback.deliver
      redirect_to "/"
    else
      render :new
    end
  end
end
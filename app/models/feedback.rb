class Feedback
  include Validatable
  attr_accessor :email, :body
  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true, :message => "please enter a valid email"
  validates_presence_of :body
  
  def new_record?
    true
  end
  
  def id
    nil
  end
  
  def deliver
    FeedbackMailer.deliver_feedback_email(self)
  end
end
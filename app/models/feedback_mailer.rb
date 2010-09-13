class FeedbackMailer < ActionMailer::Base
  
  def feedback_email(feedback)
    recipients 'tinkertask@gmail.com'
    subject "Tinkertask Feedback (#{feedback.email})"
    reply_to feedback.email
    from 'tinkertasksmtp@gmail.com' #feedback.email
    body feedback.body
  end
end

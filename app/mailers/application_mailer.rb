
class ApplicationMailer < ActionMailer::Base
  require 'mailgun'	
  default from: 'info@OnixOverflow.com'
  layout 'mailer'
end

class UserMailer < ApplicationMailer
	def welcome_email(user)
    	@user = user   	 	
    	#mg_client = Mailgun::Client.new ENV['MAIL_GUN_KEY']
    	#message_params = {:from    => ENV['MAIL_GUN_GMAIL_USERNAME'],
                      #:to      => @user.email,
                      #:subject => 'Sample Mail using Mailgun API',
                      #:text    => "render user_mailer/welcome_email"}
    	#mg_client.send_message ENV['MAIL_GUN_DOMAIN'], message_params
    	#mail(to: @user.email, subject: 'Sample Email')
  	end
end

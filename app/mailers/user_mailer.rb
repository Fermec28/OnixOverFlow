class UserMailer < ApplicationMailer
	def welcome_email(user)
    	@user = user
    	text= render_to_string ( :welcome_email )     	 	 	
    	mg_client = Mailgun::Client.new ENV['MAIL_GUN_KEY']
    	message_params = {:from    => ENV['MAIL_GUN_GMAIL_USERNAME'],
                      :to      => @user.email,
                      :subject => 'Bienvenido a OnixOverFlow',                      
                      :html    =>  text.to_str}
    	mg_client.send_message ENV['MAIL_GUN_DOMAIN'], message_params    	
  	end
end

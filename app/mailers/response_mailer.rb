class ResponseMailer < ApplicationMailer
	def new_response_email(response)
    	@question = response.question
    	text= render_to_string ( :new_answer_email )    	
    	mg_client = Mailgun::Client.new ENV['MAIL_GUN_KEY']
    	message_params = {:from    => 'info@OnixOverflow.com',
                      :to      => @question.user.email,
                      :subject => @question.title,                      
                      :html    =>  text.to_str}
    	mg_client.send_message ENV['MAIL_GUN_DOMAIN'], message_params    	
  	end
end

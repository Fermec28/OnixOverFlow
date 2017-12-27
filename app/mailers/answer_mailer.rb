class AnswerMailer < ApplicationMailer
	def new_answer_email(answer)
    	@answer = answer
    	text= render_to_string ( :new_answer_email )    	
    	mg_client = Mailgun::Client.new ENV['MAIL_GUN_KEY']
    	message_params = {:from    => 'info@OnixOverflow.com',
                      :to      => @answer.question.user.email,
                      :subject => @answer.question.title,                      
                      :html    =>  text.to_str}
    	mg_client.send_message ENV['MAIL_GUN_DOMAIN'], message_params    	
  	end
end

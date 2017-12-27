class QuestionMailer < ApplicationMailer

	def new_question_email(question)
    	@question = question
    	text= render_to_string ( :new_question_email )
    	puts text     	 	 	
    	mg_client = Mailgun::Client.new ENV['MAIL_GUN_KEY']
    	message_params = {:from    => 'info@OnixOverflow.com',
                      :to      => @question.user.email,
                      :subject => @question.title,                      
                      :html    =>  text.to_str}
    	mg_client.send_message ENV['MAIL_GUN_DOMAIN'], message_params    	
  	end
end

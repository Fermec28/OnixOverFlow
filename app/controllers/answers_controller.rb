class AnswersController < ApplicationController
	before_action :authenticate_user!, only:[:new,:edit,:destroy]

	def create
		answer= Answer.new(answer_params)

		if answer.save
			mail=AnswerMailer.new_answer_email(answer)
			response= mail.deliver_now
			redirect_to answer.question
		else
			@error= answer.errors.full_messages
			redirect_to answer.question
		end
	end

	def show		
		@question = Question.find(params[:question_id])
		@answer= Answer.find(params[:id])
	end

	def update
		answer= Answer.find(params[:id])
		if answer.update(answer_params)
			redirect_to answer.question
		else
			@errors= answer.errors.full_messages
			render :show
		end
	end

	def destroy
		answer= Answer.find(params[:id])
		answer.destroy
		redirect_to question_path(params[:question_id])
	end


	private
	def answer_params
      params.require(:answer).permit(:body).merge(user_id: current_user.id, question_id: params[:question_id])
    end
end

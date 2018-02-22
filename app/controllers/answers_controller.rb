class AnswersController < ApplicationController
	before_action :authenticate_user!, only:[:new,:edit,:destroy]

	def create
		answer= Answer.new(answer_params)

		if answer.save
			mail=AnswerMailer.new_answer_email(answer)
			response= mail.deliver_now
			flash[:success] = "Respuesta Creada"			
			redirect_to answer.question
		else
			@errors= answer.errors.full_messages
			flash[:danger] = @errors		
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
			flash[:success] = "Respuesta Actualizada"
			redirect_to answer.question
		else
			@errors= answer.errors.full_messages
			flash[:danger] = @error
			render :show
		end
	end

	def destroy
		answer= Answer.find(params[:id])
		answer.destroy
		flash[:info] = "Respuesta Eliminada"
		redirect_to question_path(params[:question_id])
	end


	private
	def answer_params
      params.require(:answer).permit(:body).merge(user_id: current_user.id, question_id: params[:question_id])
    end
end

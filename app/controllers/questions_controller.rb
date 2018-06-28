class QuestionsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]

	def index
		if params.has_key?(:question) && params[:question] != ""
		@questions=  Question.where("title like :query",query: "%#{params[:question]}%")
		else
		@questions=Question.all
		end

	end

	def new
		@question = Question.new #para render del partial
	end

	def create		
		question = Question.new(question_params)
		if question.save
			mail=QuestionMailer.new_question_email(question)
			response= mail.deliver_now
			flash[:success] = "Pregunta Creada"			
			redirect_to question
		else
			@errors= question.errors.full_messages
			flash[:danger] = @errors
			@question = Question.new #para render del partial
			render :new
		end
	end

	def show
		@question= Question.find(params[:id])
	end

	def edit
		@question= Question.find(params[:id])
	end

	def update
		question= Question.find(params[:id])
		if question.update(question_params)
			redirect_to question
			flash[:success] = "Pregunta Actualizada"	
		else
			@errors= question.errors.full_messages
			render :edit 
		end
	end

	def destroy
		question= Question.find(params[:id])
		question.destroy
		flash[:info] = "Pregunta Eliminada"	
		redirect_to questions_path
	end

	private    
	def question_params
      params.require(:question).permit(:title, :question).merge(user_id: current_user.id)
    end
end

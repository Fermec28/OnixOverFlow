class QuestionsController < ApplicationController
	before_action :set_locale
		def set_locale
  			I18n.locale = params[:locale] || I18n.default_locale
		end
	before_action :authenticate_user!, only:[:new,:edit]

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
			redirect_to question
		else
			@errors= question.errors.full_messages
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
		else
			@errors= question.errors.full_messages
			render :edit 
		end
	end

	def destroy
		question= Question.find(params[:id])
		question.destroy
		redirect_to questions_path
	end

	private    
	def question_params
      params.require(:question).permit(:title, :question).merge(user_id: current_user.id)
    end
end

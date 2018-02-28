class VotesController < ApplicationController
	before_action :authenticate_user!, only:[:create,:destroy]

	def create
		params = vote_params
		votable = params[:votable_type].constantize.find(params[:votable_id])
	    vote = votable.votes.new(params)
	    if vote.save
	    	flash[:success] = "Voto Creado"
	    	if votable.instance_of? Question
				redirect_to votable
			elsif votable.instance_of? Answer
				redirect_to votable.question	
			end
	    else
	    	@errors = vote.errors.full_messages
			flash[:danger] = @errors
			if votable.instance_of? Question
				redirect_to votable
			elsif votable.instance_of? Answer
				redirect_to votable.question	
			end 
	    end
	end

	def destroy
		vote= Vote.find(params[:id])
		vote.destroy
		flash[:info] = "Voto Eliminado"	
		if params[:question_id]
			redirect_to question_path(params[:question_id])
		elsif params[:answer_id]
			redirect_to question_path(Answer.find(params[:answer_id]).question)
		end
	end

	private
	def vote_params	
      	params.require(:vote).permit(:votable_type, :votable_id).merge(user_id: current_user.id)      			
    end
end

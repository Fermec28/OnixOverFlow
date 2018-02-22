class VotesController < ApplicationController
	before_action :authenticate_user!, only:[:create,:destroy]

	def create
	end

	def destroy
	end

	private
	def vote_params		
      	#params.require(:comment).permit(:body, :commentable_type, :commentable_id).merge(user_id: current_user.id)      			
    end
end

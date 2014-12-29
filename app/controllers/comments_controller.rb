class CommentsController < ApplicationController

  def create
  	@comment = Comment.new(comments_params)
		if @comment.content.present?
  	
	  	# 投稿者がSubjectsのオーナーだった場合はフラグをONにする
	  	@comment.owner_flag = false
			if signed_in?
	  		@user = current_user
	 		 	@subject = @comment.subject
		  	if @subject.present? && @user.present? && @user.id == @subject.user_id
		  		@comment.owner_flag = true
		  	end 
			end

	  	if @comment.save
	  		flash[:success] = "Comment created!"
	  	else
	  		flash[:error] = "Failure!"
	  	end
	  	redirect_to(:back)
		end
  end

  def destroy
  	Comment.find(params[:id]).destroy
		flash[:success] = "Comment destroyed!"
		redirect_to(:back)
  end

  private
  	def comments_params
  		params.require(:comment).permit(:content, :subject_id)
  	end
end

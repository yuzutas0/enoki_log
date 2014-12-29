class MaterialsController < ApplicationController
	before_action :signed_in_user
	before_action :set_user
	before_action :correct_user

	# 削除
	def destroy
		Material.find(params[:id]).destroy
		flash[:success] = "Material destroyed."
		redirect_to @user
	end

	private
		# Before actions
		def set_user
			@user = current_user
		end

    def correct_user
    	@subject = Subject.find(params[:id])
    	if @subject.blank? || @user.blank? || @user.id != @subject.user_id
    		redirect_to(root_path)
    	end
    end
    
end
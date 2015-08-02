class SubjectsController < ApplicationController

	before_action :signed_in_user,    only: [:new, :create, :destroy, :edit, :log]
	before_action :set_user,          only: [:new, :create, :destroy, :edit, :log]
	before_action :correct_user,      only: [:destroy]
	before_action :edit_correct_user, only: [:edit, :log]

	# 新規作成
	def new
		@subject = Subject.new
		@subject.materials.build
	end

	def create
		@subject = Subject.new(create_subject_params)
		@subject.url = create_url
		@subject.user_id = @user.id

		# Diaryを日付分だけ生成する
		count = @subject.start_day
		while count <= @subject.end_day do
			@diary = @subject.diaries.build
			@diary.day = count
			count = count + 1
		end

		# トランザクションおよび画面遷移
		if @subject.save
			flash[:success] = "Log created!"
			redirect_to @user
		else
			flash[:error] = "Failure!"
			render 'new'
		end
	end

	# 削除
	def destroy
		Subject.find(params[:id]).destroy
		flash[:success] = "Subject destroyed."
		redirect_to @user
	end

	# テーブルビューの表示
	def show
		@subject = Subject.find_by(url: params[:url])
		return redirect_to(root_path) if @subject.blank?
		@log_display_count = @subject.diaries.where(hidden_flag: false).count
		@comment = Comment.new
		@comment.subject_id = @subject.id
	end

	# 編集
	def edit
		@subject = Subject.find_by(url: params[:url])
		redirect_to(root_path) if @subject.blank?
	end

	def update
		@subject = Subject.find(params[:id])
		@subject.updated_at = Time.now
		for diary in @subject.diaries
			diary.hidden_flag = false
		end
		if @subject.update!(update_subject_params)
	 		flash[:success] = "Subject updated"
	 		redirect_to(:back)
  	else
    	flash[:error] = "Failure"
    	render "edit"
		end
	end

	def log
		@subject = Subject.find_by(url: params[:url])
		redirect_to(root_path) if @subject.blank?
	end

	private

		# Create methods
		def create_subject_params
			params.require(:subject).permit([:title, :description, :start_day, :end_day, 
				:materials_attributes => [:id, :name, :link, :_destroy]])
		end

		def create_url
			tmp_token = SecureRandom.urlsafe_base64
			digest_token = Digest::MD5::hexdigest(tmp_token.to_s)
			digest_token[0..11]
		end

		# Update method
		def update_subject_params
			params.require(:subject).permit(:title, :description, 
				:materials_attributes => [:id, :name, :link, :_destroy], 
				:diaries_attributes => [:id, :todo, :done, :progress, :memo, :hidden_flag])
		end

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

    def edit_correct_user
    	@subject = Subject.find_by(url: params[:url])
    	if @subject.blank? || @user.blank? || @user.id != @subject.user_id
    		redirect_to(root_path)
    	end
    end

end
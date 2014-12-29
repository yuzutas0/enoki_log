class UsersController < ApplicationController
	before_action :signed_in_user,  only: [:show, :edit, :update, :resign, :destroy]
	before_action :correct_user,    only: [:update, :resign, :destroy]
	before_action :set_user,        only: [:show, :edit]
	before_action :signed_out_user, only: [:new, :create]
	
	def index
		render 'show'
	end

	def show
		@subjects = @user.subjects.paginate(page: params[:page], :per_page => 5)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Enoki Log!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	end

	def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
	end

	def resign
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to(signup_url)
	end

	private

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end

		# Before actions
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def set_user
    	@user = current_user
    	redirect_to(root_path) if @user.blank?
    end

end

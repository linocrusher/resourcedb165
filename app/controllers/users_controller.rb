class UsersController < ApplicationController
	def show
		@user = User.find(params[:id]) #save the user instance inside @user
	end

	def new

	end

	def create
		@user = User.new(user_params)

		@user.save
		redirect_to @user #Should redirect to Success Prompt Page / Thread create page
	end

	private
		def user_params #For strong parameters
			params.require(:user).permit(:username, :password)
		end

end

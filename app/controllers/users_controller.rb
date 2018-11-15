class UsersController < ApplicationController
	def new

	end

	def create
		render plain: params[:user].inspect #prints text field entries on screen
	end
end

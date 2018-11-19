class ResourceThreadsController < ApplicationController
	before_action :authenticate_user, :only => [:index, :new, :create, :show, :destroy, :edit, :update] #Only logged in users can gain access to all the actions
	def index
		@users = User.all #For thread listing
		@keyword = Keyword.find_by(text: params[:keyword]) #pass the search key to @keyword
	end

	def new
		@user = User.find(params[:user_id])
		@resourcethread = @user.resource_threads.new
	end

	def edit
		@user = User.find(params[:user_id])
		@resourcethread = @user.resource_threads.find(params[:id])
	end

	def create
		@user = User.find(params[:user_id])
		@resourcethread = @user.resource_threads.create(resourcethread_params)

		if @resourcethread.save
			redirect_to user_resource_thread_path(@user.id, @resourcethread.id)
		else
			render 'new'
		end
	end

	def update
		@user = User.find(params[:user_id])
		@resourcethread = @user.resource_threads.find(params[:id])

		if @resourcethread.update(resourcethread_params)
			redirect_to user_resource_thread_path(@user.id, @resourcethread.id)
		else
			render 'edit'
		end
	end

	def show
		@user = User.find(params[:user_id])
		@resourcethread = @user.resource_threads.find(params[:id])
	end

	def destroy
		@user = User.find(params[:user_id])
		@resourcethread = @user.resource_threads.find(params[:id])
		@resourcethread.destroy

		redirect_to user_resource_threads_path(@user.id)
	end

	private
	def resourcethread_params
		params.require(:resource_thread).permit(:title, :description, :all_keywords, :keyword)
	end
end

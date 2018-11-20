class ResourceThreadsController < ApplicationController
	before_action :authenticate_user, :only => [:index, :new, :create, :show, :destroy, :edit, :update] #Only logged in users can gain access to all the actions
	def index
		@users = User.all #For thread listing
		@keyword = Keyword.find_by(text: params[:keyword]) #pass the search key to @keyword
		if params[:keyword] == nil or params[:keyword] == ""
			@status = 0 #Show all threads
		else
			if @keyword == nil
				@status = 1 #Search fail
			else
				@status = 2 #Search success
			end
		end
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
		#For folder-resource links
		if params[:type]
			@folder = @resourcethread.folders.find(params[:f_id])
			@resource = @resourcethread.resources.find(params[:r_id])
		end
		if params[:type] == "add"
			if Rfile.exists?(:resource => @resource, :folder => @folder) == false
				Rfile.create(:resource => @resource, :folder => @folder)
			end
		elsif params[:type] == "delete"
			@rfile = Rfile.where(:resource => @resource, :folder => @folder)
			@rfile.destroy_all
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@resourcethread = @user.resource_threads.find(params[:id])
		@resourcethread.destroy

		redirect_to user_resource_threads_path(@user.id)
	end

	private
	def resourcethread_params
		params.require(:resource_thread).permit(:title, :description, :all_keywords, :keyword, :r_id, :f_id, :action)
	end
end

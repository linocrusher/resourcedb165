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

		@view = params[:view]
		#For index view type
		if params[:view] == "user"
			@view = "user"
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
			 @resourcethread.update_attribute(:resource_count, 0)
			 #Update keyword instances
			 @resourcethread.keywords.each do |k|
			 	count = Keyword.where(:text => k.text).count
			 	k.update_attribute(:instances, count)
			 end

			redirect_to user_resource_thread_path(@user.id, @resourcethread.id)
		else
			render 'new'
		end
	end

	def update
		@user = User.find(params[:user_id])
		@resourcethread = @user.resource_threads.find(params[:id])

		if @resourcethread.update(resourcethread_params)
			#Update keyword instances
			 @resourcethread.keywords.each do |k|
			 	count = Keyword.where(:text => k.text).count
			 	k.update_attribute(:instances, count)
			 end
			redirect_to user_resource_thread_path(@user.id, @resourcethread.id)
		else
			render 'edit'
		end
	end

	def show
		@user = User.find(params[:user_id])
		@resourcethread = @user.resource_threads.find(params[:id])
		#For folder-resource links
		if params[:type] and params[:f_id] != nil
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
		#For votes
		if params[:v_type]
			@resource = @resourcethread.resources.find(params[:r_id])

			if params[:v_type] == "up"
				if Vote.exists?(:user => @current_user, :resource => @resource) == false
					Vote.create(:user => @current_user, :resource => @resource, :value => "up")
				elsif Vote.exists?(:user => @current_user, :resource => @resource, :value => "down")
					@vote = Vote.find_by(:user => @current_user, :resource => @resource)
					@vote.update_attribute(:value, "up")
				end
			elsif params[:v_type] == "down"
				if Vote.exists?(:user => @current_user, :resource => @resource) == false
					Vote.create(:user => @current_user, :resource => @resource, :value => "down")
				elsif Vote.exists?(:user => @current_user, :resource => @resource, :value => "up")
					@vote = Vote.find_by(:user => @current_user, :resource => @resource)
					@vote.update_attribute(:value, "down")
				end
			elsif params[:v_type] == "none"
				if Vote.exists?(:user => @current_user, :resource => @resource)
					@vote = Vote.where(:user => @current_user, :resource => @resource)
					@vote.destroy_all
				end
			end
			#For trust recalculation
			score = Vote.where(:resource => @resource, :value => "up").count 
			total = Vote.where(:resource => @resource).count
			if total != 0 
				trust_val = (score.to_f/total.to_f) * 100
			else
				trust_val = 100 #If there are no votes, trust is set to 100
			end
			@resource.update_attribute(:trust, trust_val)
		end
	end

	def destroy
		@user = User.find(params[:user_id])
		@resourcethread = @user.resource_threads.find(params[:id])
		@tags = Tag.where(:resource_thread => @resourcethread) #Delete all links to associated tags
		@folders = Folder.where(:resource_thread => @resourcethread) #Delete all folders
		@resources = Resource.where(:resource_thread => @resourcethread) #Delete all resources
		@tags.destroy_all

		@folders.each do |f| #Delete all links from resources to folders
			@rfile = Rfile.where(:folder => f)
			@rfile.destroy_all
		end

		@folders.destroy_all

		#Delete all votes
		@resources.each do |r|
			@vote = Vote.where(:resource => r)
			@vote.destroy_all
		end

		@resources.destroy_all
		@resourcethread.destroy

		#Update keyword instances
		 @resourcethread.keywords.each do |k|
		 	k.decrement!(:instances)
		 end

		redirect_to user_resource_threads_path(@user.id)
	end

	private
	def resourcethread_params
		params.require(:resource_thread).permit(:title, :description, :all_keywords, :keyword, :r_id, :f_id, :action, :v_type, :view)
	end
end

class ResourcesController < ApplicationController
  before_action :authenticate_user, :only => [:create, :index, :destroy] #Only logged in users can gain access to all the actions
  def create
    @user = User.find(params[:user_id])
	@resourcethread = @user.resource_threads.find(params[:resource_thread_id])
    @resource = @resourcethread.resources.create(resource_params)
    redirect_to user_resource_thread_path(@user, @resourcethread)
  end
 
  def index
  	@user = User.find(params[:user_id])
	@resourcethread = @user.resource_threads.find(params[:resource_thread_id])
	redirect_to user_resource_thread_path(@user, @resourcethread)
  end

  def destroy
	@user = User.find(params[:user_id])
	@resourcethread = @user.resource_threads.find(params[:resource_thread_id])
	@resource = @resourcethread.resources.find(params[:id])
	@resource.destroy

	redirect_to user_resource_thread_path(@user, @resourcethread)
  end

  private
    def resource_params
      params.require(:resource).permit(:text)
    end
end

class FoldersController < ApplicationController
  before_action :authenticate_user, :only => [:create, :index, :destroy] #Only logged in users can gain access to all the actions
  def create
    @user = User.find(params[:user_id])
	  @resourcethread = @user.resource_threads.find(params[:resource_thread_id])
    @folder = @resourcethread.folders.create(folder_params)
    redirect_to user_resource_thread_path(@user, @resourcethread)
  end

  def destroy
  	@user = User.find(params[:user_id])
  	@resourcethread = @user.resource_threads.find(params[:resource_thread_id])
  	@folder = @resourcethread.folders.find(params[:id])
    @tbd = Rfile.where(:folder => @folder) #Unlink all resources
    @tbd.destroy_all
  	@folder.destroy
  	redirect_to user_resource_thread_path(@user, @resourcethread)
  end

  private
    def folder_params
      params.require(:folder).permit(:name)
    end
end

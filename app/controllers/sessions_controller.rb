class SessionsController < ApplicationController
  layout false
  before_action :authenticate_user, :only => [:logout] #User can only access logout if logged in
  before_action :save_login_state, :only => [:login, :login_attempt] #Prevent access to the login page if user is already logged in

  def login
  end

  def login_attempt
  	authorized_user = User.authenticate(params[:username],params[:password])
  	if authorized_user
  		session[:user_id] = authorized_user.id
  		redirect_to user_resource_threads_path(authorized_user.id) #Should redirect to Thread Index Page
  	else
  		#Still missing error prompt
  		render "login"
  	end
  end

  def logout
	  session[:user_id] = nil
	  redirect_to home_index_path
  end

end

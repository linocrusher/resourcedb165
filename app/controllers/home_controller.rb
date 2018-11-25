class HomeController < ApplicationController
  layout false
  before_action :save_login_state, :only => [:index] #Prevent access to the home page if user is already logged in

  def index

  end

end

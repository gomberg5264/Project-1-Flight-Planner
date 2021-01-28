class SessionsController < ApplicationController
  before_action :check_for_no_login, except: [:destroy]

  def new
  end

  def create
    user = User.find_by :email => params[:email]
    if user.present? && user.authenticate(params[:password])
      # Create a new user session
      session[:user_id] = user.id
      redirect_to root_path
    else
      # Save the errors associated with an attempted login
      flash[:error] = "Invalid email or password"
      redirect_to sessions_new_path
    end
  end

  def destroy
      # End a user session
      session[:user_id] = nil
      redirect_to root_path
  end
end

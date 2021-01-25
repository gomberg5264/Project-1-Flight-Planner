class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by :email => params[:email]
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "Invalid email or password"
      redirect_to sessions_new_path
    end
  end

end

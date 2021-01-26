class ApplicationController < ActionController::Base
  before_action :fetch_user

  private
  def fetch_user
    @current_user = User.find_by :id => session[:user_id] if session[:user_id].present?
    session[:user_id] = nil unless @current_user.present?
  end

  def check_for_login
    redirect_to sessions_new_path unless @current_user.present?
  end

  # This method prevents users from trying to signup or login, while already logged in
  def check_for_no_login
    redirect_to user_path(@current_user.id) if @current_user.present?
  end

  # This method was created to prevent logged in users accessing the records of other logged in users
  def check_for_specific_user
    redirect_to user_path(@current_user.id) unless @current_user.id == params[:id].to_i
  end

  def check_for_admin
    redirect_to root_path unless @current_user.present? && @current_user.admin?
  end
end

class UsersController < ApplicationController
  before_action :check_for_admin, only: [:index]
  before_action :check_for_no_login, only: [:new, :create]
  before_action :check_for_specific_user, only: [:update, :show, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.create user_params
    if user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    user = User.find params[:id]
    user.update user_params
    redirect_to user_path(user.id)
  end

  def show
    @user = User.find params[:id]
  end

  def destroy
    user = User.find params[:id]
    user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :mobile, :password, :password_confirmation)
  end
end

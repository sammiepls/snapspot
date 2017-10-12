class UsersController < ApplicationController
  before_action :set_users, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash.now[:success] = "Account successfully created!"
      redirect_to root_path
    else
      flash.now[:error] = "There was an error creating your account."
      @errors = @user.errors.full_messages
      render template: "users/new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Your details have been updated successfully."
      redirect_to user_path(@user)
    else
      flash.now[:error] = "There was an error updating your account."
      @errors = @user.errors.full_messages
      render template: "users/edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:username,:email,:first_name,:last_name,:password,:password_confirmation,:avatar,:created_at,:updated_at)
  end

  def set_users
    @user = User.find(params[:id])
  end
end

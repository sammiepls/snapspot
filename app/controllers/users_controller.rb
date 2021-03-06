class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.capitalize
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
    @snapspots = @user.snapspots.paginate(:page => params[:page], :per_page => 9)
  end

  def edit
  end

  def update
    @snapspots = @user.snapspots.paginate(:page => params[:page], :per_page => 9)
    if @user.update_attributes(user_params)
      flash[:success] = "Your details have been updated successfully."
      render template: "users/show"
    else
      @errors = @user.errors.full_messages
      render template: "users/edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:username,:email,:first_name,:last_name,:password,:password_confirmation,:avatar,:created_at,:updated_at,:avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

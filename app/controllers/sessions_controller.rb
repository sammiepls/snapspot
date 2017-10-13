class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_email(params[:username])
    if @user && user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in"
      redirect_to '/'
    else
      flash.now[:error] = "Login unsuccessful"
      render template: "sessions/new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end

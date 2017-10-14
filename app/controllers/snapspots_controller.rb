class SnapspotsController < ApplicationController

  def index
    @snapspots = Snapspot.all
  end

  def new
    @snapspot = Snapspot.new
  end

  def create
    @snapspot = Snapspot.new(snapspot_params)
    if @snapspot.save
      flash.now[:success] = "Account successfully created!"
      render template: "snaspot/index"
    else
      flash.now[:error] = "There was an error creating your account."
      render template: "users/new"
    end
  end
  
  private

  def snapspot_params
    params.require(:user).permit(:name, :description, :address, :latitude, :longitude, :created_at,:updated_at)
  end

  def set_snapspot
    @snapspot = Snapspot.find(params[:id])
  end
end

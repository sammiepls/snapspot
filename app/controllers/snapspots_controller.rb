class SnapspotsController < ApplicationController
  before_action :set_snapspot, only: [:show, :edit, :update, :destroy]

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
      render template: "snapspots/show"
    else
      flash.now[:error] = "There was an error creating your account."
      @errors = @snapspot.errors.full_messages
      render template: "snapspots/new"
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def user_snapspots
    @user = User.find(params[:id])
    @snapspots = Snapspot.where(user_id:params[:id])
  end

  private

  def snapspot_params
    params.require(:snapspot).permit(:user_id, :name, :description, :address, :latitude, :longitude, :created_at,:updated_at)
  end

  def set_snapspot
    @snapspot = Snapspot.find(params[:id])
  end
end

class SnapspotsController < ApplicationController
  before_action :require_login
  before_action :set_snapspot, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Snapspot.tag_counts.order('taggings_count DESC').first(10)
    if params[:tag]
      @snapspots = Snapspot.tagged_with(params[:tag])
    elsif params[:search]
      @snapspots = Snapspot.search(params[:search])
    else
      @snapspots = Snapspot.all
    end
    @snapspots = @snapspots.paginate(:page => params[:page], :per_page => 12)
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
    if @snapspot.update_attributes(snapspot_params)
      flash[:success] = "Your SnapSpot has been updated successfully."
      redirect_to snapspot_path(@snapspot)
    else
      @errors = @snapspot.errors[:messages].join
      render template: "snapspots/edit"
    end
  end

  def destroy
    @snapspot.destroy
    flash[:success] = 'SnapSpot was successfully deleted'
    redirect_to snapspots_path
  end

  private

  def snapspot_params
    params.require(:snapspot).permit(:user_id, :name, :description, :address, :latitude, :longitude, :created_at,:updated_at,:tag_list, images: [])
  end

  def set_snapspot
    @snapspot = Snapspot.find(params[:id])
  end
end

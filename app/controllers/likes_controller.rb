class LikesController < ApplicationController
  before_action :set_user_set_snapspot

  def like
    @like = Like.new(user_id:@user.id,snapspot_id:@snapspot.id)
    if @like.save
      respond_to do |format|
        format.js
      end
    else
      flash[:error] = "You liked before!"
      render template: "snapspots/show"
    end

  end

  def unlike
    @like = @user.likes.find_by_snapspot_id(params[:snapspot_id])
    @like.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def set_user_set_snapspot
    @user = current_user
    @snapspot = Snapspot.find(params[:snapspot_id])
  end
  
end

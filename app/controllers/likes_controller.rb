class LikesController < ApplicationController

  def like
    @user = current_user
    @snapspot = Snapspot.find(params[:snapspot_id])
    @like = Like.new(user_id:@user.id,snapspot_id:@snapspot.id)
    if @like.save
      # flash[:success] = "You liked #{@user.username}'s SnapSpot!"
      render template: "snapspots/show"
    else
      # flash[:error] = "You liked before!"
      render template: "snapspots/show"
    end
    # respond_to do |format|
		# 		format.js
		# 	end
  end

  def unlike
    byebug
    @user = current_user
    @like = @user.likes.find_by_snapspot_id(params[:snapspot_id])
    @snapspot = Snapspot.find(params[:snapspot_id])
    @like.destroy
    # flash[:error] = "You unliked :( "
    render template: "snapspots/show"
  end
end

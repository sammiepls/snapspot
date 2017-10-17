class LikesController < ApplicationController
  respond_to :js

  def like
    @user = current_user
    @snapspot = Like.find(params[:snapspot_id])
    @user.like!(@snapspot)
  end

  def unlike
    @user = current_user
    @like = @user.likes.find_by_snapspot_id(params[:snapspot_id])
    @snapspot = Like.find(params[:snapspot_id])
    @like.destroy!
  end
end

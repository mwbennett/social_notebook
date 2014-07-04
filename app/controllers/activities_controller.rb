class ActivitiesController < ApplicationController
   def index
    @activities = Activity.order("created_at DESC")
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(params[:activity])
    @activity.owner = current_user 
    if @activity.save 
      redirect_to user_path(current_user)
    else
      render new_activity_path
    end
  end
  
  def edit
    #before_action :activity_authentication
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])

    if @activity.update(activity_params)
      redirect_to @activity
    else
      render 'edit'
    end
  end  

  def show
    @activity = Activity.find(params[:id])
  end

  def destroy 
    before_action :activity_authorization
    
    @activity = Activity.find(params[:id])
    @activity.destroy 

    redirect_to root_path
  end 
end

private 
  def activity_params 
    params.require(:activity)
    .permit(:description)
  end

  def activity_authorization
    unless current_user == Activity.find(params[:id]).owner
      flash[:error] = "You are not authorized to edit another user's activity"
      redirect_to user_path(current_user)
    end
  end
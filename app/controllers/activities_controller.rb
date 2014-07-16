class ActivitiesController < ApplicationController
  def new
    @activity = Activity.new
    @users = User.all - [current_user]
  end

  def convert 
    event = Event.new
    activity = Activity.find(params[:activity_id])
    event.description = activity.description 
    event.users += activity.users
    event.host = activity.host
    event.save
    redirect_to edit_event_path(event)
  end 

  def create
    @activity = Activity.new(activity_params)
    @activity.host = current_user 
    attendees = params[:user_ids].map {|id| User.find(id)}
    if @activity.save 
      @activity.users += attendees 
      redirect_to user_path(current_user)
    else
      render new_activity_path
    end
  end
  
  def edit
    # before_action :activity_authentication
    @activity = Activity.find(params[:activity_id])
    @users = User.all - [current_user]
  end

  def update
    @activity = Activity.find(params[:activity_id])

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
    # before_action :activity_authorization
    
    @activity = Activity.find(params[:id])
    @activity.destroy 

    redirect_to root_path
  end 
end

private 
  def activity_params 
    params.require(:activity)
    .permit(:description, :users)
  end

  def activity_authorization
    unless current_user == Activity.find(params[:id]).host
      flash[:error] = "You are not authorized to edit another user's activity"
      redirect_to user_path(current_user)
    end
  end
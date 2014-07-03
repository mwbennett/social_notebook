class EventsController < ApplicationController
  def index
    @events = Event.order("date DESC")
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    @event.host_id = current_user 
    if @event.save 
      redirect_to user_path
    else
      render new_event_path
    end
  end
  
  def edit
    before_action :event_authentication
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end  

  def show
    @event = Event.find(params[:id])
  end

  def destroy 
    before_action :event_authorization
    
    @event = Event.find(params[:id])
    @event.destroy 

    redirect_to root_path
  end 
end

private 
  def event_params 
    params.require(:event)
    .permit(:description, :date)
  end

  def event_authorization
    unless current_user == Event.find(params[:id]).host_id
      flash[:error] = "You are not authorized to edit another user's event"
      redirect_to user_path
    end
  end
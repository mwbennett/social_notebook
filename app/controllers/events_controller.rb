class EventsController < ApplicationController
  def new
    @event = Event.new
    @user = current_user
    @users = User.all - [current_user]
  end

  def create
    @event = Event.new(event_params)
    @event.host = current_user 
    invitees = params[:user_ids].map {|id| User.find(id)}
    if @event.save 
      @event.users += invitees
      @event.users.each do |user|
        @event.send_invite(user.id)
      end
      redirect_to user_path(current_user)
    else
      render new_event_path
    end
  end
  
  def edit
    #before_action :event_authentication
    @event = Event.find(params[:id])
    @users = User.all - [current_user]
  end

  def update
    @event = Event.find(params[:id])
    invitee_ids = params[:user_ids].map {|id| id.to_i }
    invitees = invitee_ids.map {|id| User.find(id)}
    binding.pry

    if @event.update(event_params)
      @event.users = invitees  
      @event.users.each do |user|
        @event.send_invite(user.id) if Invite.where(user_id: user.id, event_id: @event.id).empty?
      end

      Invite.where(event_id: @event.id).each do |thing|
        thing.destroy if !invitee_ids.include?(thing.user_id)
      end
      redirect_to current_user
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
    .permit(:description, :date, :users)
  end

  def event_authorization
    unless current_user == Event.find(params[:id]).host_id
      flash[:error] = "You are not authorized to edit another user's event"
      redirect_to user_path
    end
  end
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save 
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render new_user_path
    end
  end

  def edit
    # before_action :user_authorization
    current_user
    @user = @current_user
  end
  
  def update 
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def show
    current_user
    @user = User.find(params[:id])
    @user.sync_events

    @activities = @user.hosted_activities.order("created_at DESC")
    @events = @user.hosted_events.order("created_at DESC")
    @invites = @user.invites.order("created_at DESC")
  end

  def destroy 
    before_action :user_authorization
    
    @user = User.find(params[:id])
    @user.destroy 

    redirect_to root_path
  end
end

private 
  def user_params 
    params.require(:user)
    .permit(:first_name, :last_name, :email, :password)
  end

  def user_authorization
    unless current_user == User.find(params[:id])
      flash[:error] = "You are not authorized to edit another user's profile"
      redirect_to user_path(current_user)
    end
  end

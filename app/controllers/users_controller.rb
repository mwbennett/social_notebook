class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save 
      redirect_to user_path
    else
      render new_user_path
    end
  end

  def edit
    before_action :user_authorization
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])

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
      redirect_to user_path
    end
  end

class SessionsController < ApplicationController
  def new
  end 

  def create 
    @user = User.where(email: params[:email]).first
    if @user && @user.authenticate(params[:password])
      session[:current_user_id] = @user.id
      redirect_to users_path
    else 
      flash[:alert] = 'Incorrect email or password'
      redirect_to root_path
    end    
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path 
  end 
end

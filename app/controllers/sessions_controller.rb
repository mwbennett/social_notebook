class SessionsController < ApplicationController
  def new
    redirect_to user_path(current_user) if current_user
  end 

  def create 
    @user = User.where(email: params[:user][:email]).first
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Login successful"
      redirect_to user_path(current_user)
    else 
      flash[:alert] = 'Incorrect email or password'
      redirect_to root_path
    end    
  end

  def destroy
    current_user = session[:user_id] = nil
    redirect_to root_path 
  end 
  
  private 
    def user_params 
      params.require(:user)
      .permit(:email, :password)
    end
end

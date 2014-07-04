class SessionsController < ApplicationController
  def new
  end 

  def create 
    @user = User.where(email: params[:user][:email]).first
    puts "FIND ME"
    puts @user.inspect
    if @user && @user.authenticate(params[:user][:password])
      session[:current_user_id] = @user.id
      flash[:notice] = "Login successful"
      redirect_to new_user_path
    else 
      flash[:alert] = 'Incorrect email or password'
      redirect_to root_path
    end    
  end

  def destroy
    @_current_user = session[:current_user_id] = nil
    redirect_to root_path 
  end 
  
  private 
    def user_params 
      params.require(:user)
      .permit(:email, :password)
    end
end

class InvitesController < ApplicationController
  def accept 
    @invite = Invite.find(params[:invite_id])
    @invite.status = true
    @invite.save
    redirect_to user_path(current_user)
  end 

  def decline 
    @invite = Invite.find(params[:invite_id])
    @invite.status = false
    @invite.save
    redirect_to user_path(current_user)
  end 
end

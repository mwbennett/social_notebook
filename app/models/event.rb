class Event < ActiveRecord::Base
  belongs_to :host, class_name: "User" 
  has_and_belongs_to_many :users
  belongs_to :activity
  has_many :invites

  def send_invite(user_id)
    user_invite = Invite.new 
    user_invite.user_id = user_id
    user_invite.event_id = self.id
    user_invite.save
  end

  def convert_to_activity
    activity = Activity.new 
    activity.description = self.description
    activity.users += self.users
    activity.date = self.date 
    activity.host = self.host
    activity.save
    self.invites.destroy_all
    self.destroy
  end
end

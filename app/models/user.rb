class User < ActiveRecord::Base
  has_and_belongs_to_many :activities, -> { uniq }, join_table: :users_activities
  has_and_belongs_to_many :events, -> { uniq }
  has_many :invites
  has_many :hosted_activities, :class_name => 'Activity', :foreign_key => :host_id
  has_many :hosted_events, :class_name => 'Event', :foreign_key => :host_id
  
  has_secure_password
  validates_confirmation_of :password 
  validates_presence_of :password, on: :create 

  def full_name 
    "#{first_name} #{last_name}"  
  end

  def sync_events
    self.hosted_events.each do |event|
      if Time.now > event.date ||= Time.now
        event.convert_to_activity
      end
    end
  end

end

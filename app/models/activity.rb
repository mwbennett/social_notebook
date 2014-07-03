class Activity < ActiveRecord::Base
  has_and_belongs_to_many :users, -> { uniq }, join_table: :users_activities
  
  has_one :event

  belongs_to :owner, class_name 'User'
end



=begin 

Class Event 
  
  belongs_to :activity 

  has_many :invites

  has_many :invited_users, through: :invites, class_name: "User"

  has_many :activity_users, through: :activity, class_name: "User"

  has_one :admin, class_name: "User", source: admin_id

scopes 

=end
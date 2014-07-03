class User < ActiveRecord::Base
  has_and_belongs_to_many :activities, -> { uniq }, join_table: :users_activities
  
  has_and_belongs_to_many :events, -> { uniq }

  has_many :activity_users, through: :activity, class_name: "User"

  has_secure_password
  validates_confirmation_of :password 
  validates_presence_of :password, on: :create 
end

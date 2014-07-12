class Event < ActiveRecord::Base
  belongs_to :host, class_name: "User" 
  has_and_belongs_to_many :users
  belongs_to :activity
  has_many :invites
end

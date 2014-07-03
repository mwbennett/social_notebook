class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  belongs_to :activity
  
  belongs_to :host_id, class_name: "User" 
end

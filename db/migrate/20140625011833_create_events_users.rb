class CreateEventsUsers < ActiveRecord::Migration
  def change
    create_table :events_users do |t|
      t.integer :user_id
      t.integer :event_id
    end
  end
end

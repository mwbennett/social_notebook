class CreateUsersActivities < ActiveRecord::Migration
  def change
    create_table :users_activities, id: false do |t|
      t.belongs_to :user
      t.belongs_to :activity
    end
  end
end

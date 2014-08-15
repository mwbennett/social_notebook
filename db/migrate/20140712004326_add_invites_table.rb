class AddInvitesTable < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :status

      t.timestamps
    end
  end
end

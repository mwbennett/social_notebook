class AddOwnerToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :owner, :integer
  end
end

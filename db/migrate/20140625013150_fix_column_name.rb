class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :events, :user_id, :host_id
  end
end

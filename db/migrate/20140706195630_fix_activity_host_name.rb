class FixActivityHostName < ActiveRecord::Migration
  def change
    rename_column :activities, :owner, :host_id
  end
end

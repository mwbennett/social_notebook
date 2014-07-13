class ChangeStatusDatatype < ActiveRecord::Migration
  def change
    change_column :invites, :status, :boolean
  end
end

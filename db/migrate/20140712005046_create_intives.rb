class CreateIntives < ActiveRecord::Migration
  def change
    create_table :intives do |t|

      t.timestamps
    end
  end
end

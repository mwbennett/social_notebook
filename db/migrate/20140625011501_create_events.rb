class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.datetime :date
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
  end
end

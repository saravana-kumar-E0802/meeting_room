class CreateRoomResources < ActiveRecord::Migration
  def change
    create_table :room_resources do |t|
      t.integer :room_id
      t.integer :resource_id
      t.integer :count
      t.timestamps null: false
    end
  end
end

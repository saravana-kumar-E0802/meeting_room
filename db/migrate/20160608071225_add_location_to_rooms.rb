class AddLocationToRooms < ActiveRecord::Migration
  def up
  	add_column :rooms, :location, :string
  end
  def down
  	remove_column :rooms, :location
  end
end

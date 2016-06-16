class AddIndexToAppointment < ActiveRecord::Migration
  def up
  	add_index :appointments, [:user_id, :room_id]
  end
  def down
  	remove_index :appointments, [:user_id, :room_id]
  end
end

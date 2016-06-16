class RemoveIndexOnAppointment < ActiveRecord::Migration
  def up
  	remove_index :appointments, [:user_id, :room_id]
  end
  def down
  	add_index :appointments, [:user_id, :room_id]
  end
end

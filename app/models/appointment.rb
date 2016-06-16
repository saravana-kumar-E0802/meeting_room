class Appointment < ActiveRecord::Base
	belongs_to :room
	belongs_to :user

	validates_presence_of :room, :user

	scope :sorted,  lambda {order("start_time asc, end_time asc")}

  def room_check
    if(self.room)
      return self.room.name
    else
      return ""
    end
  end

  def user_check
    if(self.user)
      return self.user.email
    else
      return ""
    end
  end

end

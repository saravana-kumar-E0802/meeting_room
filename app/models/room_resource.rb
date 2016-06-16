class RoomResource < ActiveRecord::Base
	belongs_to :room
	belongs_to :resource

	validates_associated :room, :resource
	validates :count, :numericality => true
end

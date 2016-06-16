class Room < ActiveRecord::Base

	has_many :room_resources
	has_many :resources, through: :room_resources

	has_many :appointments
	has_many :users, through: :appointments

	scope :sorted, lambda {order("name asc")}
	validates :name, :presence => true,
					:length => {:maximum => 30}
end

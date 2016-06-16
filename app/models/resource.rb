class Resource < ActiveRecord::Base
	has_many :room_resources
	has_many :rooms, :through => :room_resources
	
	scope :sorted, lambda {order("name asc")}
	validates :name, :presence => true,
					:length => {:maximum => 30}
end

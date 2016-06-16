class User < ActiveRecord::Base
	has_secure_password
	
  has_many :appointments
  has_many :rooms, through: :appointments

	scope :sorted, lambda {order("first_name asc, last_name asc")}

	validates :first_name,
        :presence => true
  validates :last_name,
        :presence => true
  validates :email,
        :presence => true,
        :uniqueness => true,
        :format => {
          :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        }
  validates :password,
      :presence => true,
      :confirmation => true,
      :format => {
      	:with => /\A^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/,
      	:message => "Password must at least be of 6 characters and include one number and one letter"
      }
  def to_s
    "#{first_name} #{last_name}"
  end
end

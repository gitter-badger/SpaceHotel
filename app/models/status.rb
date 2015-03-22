class Status < ActiveRecord::Base

  has_many :bookings

  validates :name, uniqueness: true

end

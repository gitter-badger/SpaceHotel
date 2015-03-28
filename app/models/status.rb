class Status < ActiveRecord::Base

  has_many :bookings

  validates :name, uniqueness: true

  def self.options_for_select
    all.map { |e| [e.name, e.id] }
  end

end

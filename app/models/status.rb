class Status < ActiveRecord::Base

  has_many :bookings

  validates :name, uniqueness: true

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

end

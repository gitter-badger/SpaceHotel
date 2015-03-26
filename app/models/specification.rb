class Specification < ActiveRecord::Base

  has_many :rooms

  validates :name, uniqueness: true

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

end

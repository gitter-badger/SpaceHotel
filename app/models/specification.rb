class Specification < ActiveRecord::Base

  has_many :rooms

  validates :name, uniqueness: true

end

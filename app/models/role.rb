class Role < ActiveRecord::Base

  ALL = [{:id => 1, :name => 'customer'},
         {:id => 2, :name => 'admin'},
         {:id => 3, :name => 'super_admin'}]

  has_many :users

  validates :name, uniqueness: true

  def self.options_for_select
    all.map { |e| [e.name, e.id] }
  end

end

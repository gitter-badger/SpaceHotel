class Article < ActiveRecord::Base

  include Bootsy::Container

  belongs_to :user

  validates :title, length: { in: 4..128 }

end

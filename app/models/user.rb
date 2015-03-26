class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :init

  belongs_to :role
  has_many :bookings

  def init
    Role::ALL.each do |role|
      eval <<-RUBY
           def #{role[:name]}?
             self.role_id == #{role[:id]}
           end
           RUBY
    end
  end
end

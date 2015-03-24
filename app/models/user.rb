class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :init

  belongs_to :role
  has_many :bookings

  def init
    %w[customer admin super_admin].each_with_index do |r, i|
      eval <<-RUBY
           def #{r}?
             self.role_id == #{i+1}
           end
           RUBY
    end
  end
end

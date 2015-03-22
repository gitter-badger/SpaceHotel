class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :init

  belongs_to :role

  def init
    self.role = Role.find_by_name("customer") unless self.role

    Role.all.each do |r|
      eval %Q"
           def #{r.name}?
             self.role_id == #{r.id}
           end
           "
    end
  end
end

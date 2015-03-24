class RegistrationMailer < ActionMailer::Base
  default from: "space.hotel55@gmail.com"

  def welcome(user, user_password)
      @user_password = user_password
      mail( :to => user.email,
            :subject => 'Thanks for signing up for our amazing app' )
  end
end

class UserMailer < ActionMailer::Base
  default from: "from@gk.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.weather.subject
  #
  def weather(user, weekly)
    @user = user
    @weekly = weekly

    mail to: user.email, subject: "Office Staff work days"
  end

  def it_email(user,weekly)
    @user = user
    @weekly = weekly

    mail to: user.email, subject: "IT Staff Work days"
  end
end

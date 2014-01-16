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

    mail to: user.email, subject: "Your work days"
  end
end

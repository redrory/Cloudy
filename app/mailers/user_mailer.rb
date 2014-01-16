class UserMailer < ActionMailer::Base
  default from: "from@gk.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.weather.subject
  #
  def weather(user)
    @user = user

    mail to: user.email, subject: "Your work days"
  end
end

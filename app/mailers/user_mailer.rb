class UserMailer < ActionMailer::Base
  default from: "#{I18n.t 'site_name'} <#{ENV['DEFAULT_EMAIL_SENDER']}>"
  default reply_to: ENV['DEFAULT_CONTACT_EMAIL']

  layout "email_template"

  def reset_password_email(user)
    @user = user
    mail(to: user.email)
  end

  def welcome(user)
  	@user = user
  	mail(to: user.email)
  end

  def new_account_member(user, random_password)
    @user = user
    @random_password = random_password
    mail(to: @user.email)
  end

end
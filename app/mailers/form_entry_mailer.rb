class FormEntryMailer < ActionMailer::Base
  default from: "#{I18n.t 'site_name'} <#{ENV['DEFAULT_EMAIL_SENDER']}>"
  default reply_to: ENV['DEFAULT_CONTACT_EMAIL']

  def notify_recipient(entry)
  	@entry = entry
  	mail(to: @entry.form.persons_to_notify)
  end
end

# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  default from: ENV.fetch('MAIL_SENDER', nil)
  layout 'mailer'
  default template_path: 'devise/mailer'

  def devise_mail(record, action, opts = {}, &)
    initialize_from_record(record)
    make_bootstrap_mail(headers_for(action, opts), &)
  end
end

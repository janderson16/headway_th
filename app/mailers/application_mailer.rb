class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@headway_th.com',
          return_path: 'contact@headway_th.com'

  layout 'mailer'

  def email(to_address, subject, body)
    options = { to: to_address, subject: subject, body: body }
    mail options
  end
end

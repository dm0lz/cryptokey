class EmailsMailbox < ApplicationMailbox
  def process
    user.emails.create(
      from: mail.from,
      to: mail.to,
      subject: mail.subject,
      body: mail.body
    )
  end

  def user
    User.find_by(email_address: mail.to)
  end
end

class EmailsMailbox < ApplicationMailbox
  def process
    Email.create(
      from: mail.from,
      to: mail.to,
      subject: mail.subject,
      body: mail.body
    )
  end
end

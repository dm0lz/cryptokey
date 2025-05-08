class EmailsMailbox < ApplicationMailbox
  def process
    Email.create!(
      from_email: mail.from&.first,
      to_email: mail.to&.first,
      subject: mail.subject,
      body: mail.body.decoded
    )
  end
end

class EmailsMailbox < ApplicationMailbox
  def process
    Email.create!(
      from_email: mail.from&.first,
      to_email: mail.to&.first,
      from_emails: mail.from,
      to_emails: mail.to,
      subject: mail.subject,
      body: mail_body
    )
  end

  private

  def mail_body
    if mail.multipart?
      mail.text_part.body.decoded
    else
      mail.body.decoded
    end
  end
end

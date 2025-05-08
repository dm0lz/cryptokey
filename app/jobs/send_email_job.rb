class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(email_id)
    email = Email.find(email_id)
    return if email.to_email.end_with?("@cryptokey.email")

    Mailgun::SenderService.new(email).call
    # TODO: Replace with actual mailer logic
    # Example: UserMailer.with(email: email).send_email.deliver_later
    Rails.logger.info "Sending email to \\#{email.to_email}: \\#{email.subject}"
  end
end 
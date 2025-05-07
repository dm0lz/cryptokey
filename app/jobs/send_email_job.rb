class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(email_id)
    email = Email.find(email_id)
    Mailgun::SenderService.new(email).call
    # TODO: Replace with actual mailer logic
    # Example: UserMailer.with(email: email).send_email.deliver_later
    Rails.logger.info "Sending email to \\#{email.to}: \\#{email.subject}"
  end
end 
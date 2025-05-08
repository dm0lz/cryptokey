class ApplicationMailer < ActionMailer::Base
  default from: "support@cryptokey.email"
  layout "mailer"
end

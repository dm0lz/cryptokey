class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  routing /@cryptokey\.email\z/i => :emails
  # routing :all => :emails
end

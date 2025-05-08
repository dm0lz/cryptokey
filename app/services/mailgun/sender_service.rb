require 'net/http'
require 'base64'

class Mailgun::SenderService
  def initialize(email)
    @email = email
  end

  def call
    uri = URI('https://api.eu.mailgun.net/v3/cryptokey.email/messages')
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(
      'from' => "#{@email.from_email} <#{@email.from_email}>",
      'to' => "#{@email.to_email} <#{@email.to_email}>",
      'subject' => "#{@email.subject}",
      'text' => "#{@email.body}"
    )
    request['Authorization'] = "Basic #{Base64.strict_encode64("api:#{Rails.application.credentials.mailgun_api_key}")}"
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
    response.body
  end
  
end




require 'json'

class Email < ApplicationRecord
  before_validation :sanitize_from_and_to
  validates :from_email, :to_email, format: { with: URI::MailTo::EMAIL_REGEXP }

  private

  def sanitize_from_and_to
    self.from_email = parse_email(self.from_email)
    self.to_email = parse_email(self.to_email)
  end

  def parse_email(value)
    value.include?("[") ? JSON.parse(value).first : value
  end
end

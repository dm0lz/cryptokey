require 'json'

class Email < ApplicationRecord
  before_validation :sanitize_from_and_to

  private

  def sanitize_from_and_to
    self.from = parse_email(self.from)
    self.to = parse_email(self.to)
  end

  def parse_email(value)
    JSON.parse(value).first
  end
end

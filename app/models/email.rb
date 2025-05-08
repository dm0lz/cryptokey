class Email < ApplicationRecord
  before_validation :sanitize_from_and_to

  private

  def sanitize_from_and_to
    self.from = Array(self.from).first if self.from.is_a?(Array)
    self.to = Array(self.to).first if self.to.is_a?(Array)
  end
end

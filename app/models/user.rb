class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, :recovery_email, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :recovery_email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email_address, format: { with: /\A[^@]+@cryptokey\.email\z/, message: "must end with cryptokey.email" }
  validates :email_address, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validates :password_confirmation, presence: true, if: -> { password.present? }
end

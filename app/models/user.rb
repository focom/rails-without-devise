# frozen_string_literal: true

class User < ActiveRecord::Base
  has_secure_password(validations: false)
  validates :username, presence: true, length: { minimum: 5 }, on: :update, if: :will_save_change_to_username?
  validates :password, confirmation: true, presence: { on: create }, length: { minimum: 8 }, if: :will_save_change_to_password_digest?
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  before_create :set_username

  def set_username
    self.username = email.split('@')[0]
  end
end

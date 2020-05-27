# frozen_string_literal: true

require 'test_helper'

class PasswordRecoveryMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
  end
  test 'reset password email' do
    email = PasswordRecoveryMailer.with(user: @user).set_password_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['notifications@example.com'], email.from
    assert_equal [@user.email], email.to
    assert_equal 'Reset email', email.subject
    assert email.body.include? '/set/password/' + @user.reset_password_token
  end
end

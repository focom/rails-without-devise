# frozen_string_literal: true

require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
  end
  test 'invite' do
    email = UserMailer.with(user: @user).welcome_email

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['notifications@example.com'], email.from
    assert_equal [@user.email], email.to
    assert_equal 'Welcome email', email.subject
  end
end

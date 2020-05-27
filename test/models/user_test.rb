# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: 'john@example.com', password: '123456789', password_confirmation: '123456789')
  end
  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without password' do
    @user= User.new(email: 'john@example.com', password: '123', password_confirmation: '123456789')
    refute @user.valid?
    assert_not_nil @user.errors[:password], 'no validation password for name present'
  end

  test 'invalid without email' do
    @user.email = nil
    refute @user.valid?
    assert_not_nil @user.errors[:email]
  end

  test 'can not update with a short username' do
    @user.save
    @user.update(username: 'klkl')
    refute @user.valid?, 'user is valid without a name'
    assert_not_nil @user.errors[:username], 'no validation error for username length'
  end

end

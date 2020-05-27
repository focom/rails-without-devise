require 'test_helper'

class PasswordRecoveryControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test 'Reset form' do
    user = User.create(email: 'test@example.com', password: '012345678', password_confirmation: '012345678')
    visit(login_path)
    click_link('Reset password')
    current_path.should == reset_password_path
    assert_template 'password_recovery/index'
    fill_in('email', with: user.email)
    click_button('Send reset email')
    user.reload
    assert user.reset_password_token
    assert user.reset_password_sent_at
    visit(set_password_path(user.reset_password_token))
    fill_in('user[password]', with: 876543210)
    fill_in('user[password_confirmation]', with: 876543210 )
    click_on('Reset password')
    current_path.should == login_path
    user.reload
    assert user.authenticate('876543210')
  end

end

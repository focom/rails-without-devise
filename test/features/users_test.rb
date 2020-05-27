# frozen_string_literal: true
require 'test_helper'
require 'capybara/dsl'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test 'Registration' do
    visit(new_user_path)
    assert_response :success
    assert_template 'users/new'
    fill_in('user[email]', with: 'test@email.com')
    fill_in('password', with: '12345678' )
    fill_in('password_confirmation', with: '12345678' )
    click_on('Save User')
    test_user = User.find_by(email: 'test@email.com')
    assert test_user
  end

  test 'Login and update personal info' do
    user = User.create(email: 'test@example.com', password: '12345678', password_confirmation: '12345678')
    visit(login_path)
    fill_in('email', with: 'test@example.com')
    fill_in('password', with: '12345678' )
    click_button('Login')
    current_path.should == user_path(user.id)
    assert_text 'Succesful login'
    assert_link 'Edit Profile'
    assert_link 'Logout'
    click_link('Edit Profile')
    fill_in('Username', with: 'alongusername')
    click_button('Update')
    user.reload
    assert user.username == 'alongusername'
  end

end
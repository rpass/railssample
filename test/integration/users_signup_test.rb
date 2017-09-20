require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "#create does not create a user if the form is invalid" do
    get signup_path

    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "invalid.co",
                                         password: '123',
                                         password_confirmation: '456' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test "#create creates a user if the form is valid with account activation" do
    get signup_path

    assert_difference 'User.count' do
      post users_path, params: { user: { name: "example",
                                         email: "example@example.com",
                                         password: 'Asdf;lkj',
                                         password_confirmation: 'Asdf;lkj' } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    refute is_logged_in?
    user = assigns(:user)

    #try logging in before activation
    log_in_as(user)
    refute is_logged_in?

    # try activating account with wrong token
    get edit_account_activation_path('bad token', email: user.email)
    refute is_logged_in?

    # try activating account with the wrong email
    get edit_account_activation_path(user.activation_token, email: 'bad_email')
    refute is_logged_in?

    # activate account
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    refute flash.empty?
  end
end

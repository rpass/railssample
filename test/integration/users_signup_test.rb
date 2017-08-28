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
end

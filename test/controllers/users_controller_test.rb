require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
    end

  test "should be redirected from index to login if not logged in" do
    get users_path
    assert_redirected_to login_path
  end
end

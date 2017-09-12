require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should be redirected from index to login if not logged in" do
    get users_path
    assert_redirected_to login_path
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    refute @other_user.admin?
    patch user_path(@other_user), params: {
      user: { password: 'password',
              password_confirmation: 'password',
              admin: true } }
    refute @other_user.reload.admin?
  end

  test "destroy should be redirected to login if not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "destroy should be redirected to root if not an admin" do
    log_in_as(@other_user)
    refute @other_user.admin?
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end

    assert_redirected_to root_url
  end
end

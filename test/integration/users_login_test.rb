require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {session: {email: 'donald@duck.com', password: '123'}}
    assert_template 'sessions/new'
    refute flash.empty?
    get root_path
    assert flash.empty?
  end
end

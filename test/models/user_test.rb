require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"robert", email:"rob@gmail.com")
  end

  test "default user is valid" do
    assert @user.valid?
  end
end

require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "lorem ipsum")
  end

  test "micropost should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    refute @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "   "
    refute @micropost.valid?
  end

  test "content should be a maximum of 140 characters" do
    @micropost.content = 'a'*141
    refute @micropost.valid?

    @micropost.content = 'a'*140
    assert @micropost.valid?
  end

  test "order should be most recent micropost first" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end

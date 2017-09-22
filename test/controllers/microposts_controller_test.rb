require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @micropost = microposts(:orange)
  end

  test "should redirect create to login when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_path
  end

  test "should redirect delete to login when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost.id)
    end
    assert_redirected_to login_path
  end
end

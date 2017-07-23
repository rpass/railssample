require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
# Get the root path (Home page).
# Verify that the right page template is rendered.
# Check for the correct links to the Home, Help, About, and Contact pages.
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_us_path
    assert_select "a[href=?]", signup_path
    get contact_us_path
    assert_select "title", full_title('Contact Us')
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "robert", email: "rob@gmail.com")
  end

  test "default user is valid" do
    assert @user.valid?
  end

  test "user with empty name is invalid" do
    @user.name = ""
    refute @user.valid?

    @user.name = nil
    refute @user.valid?

    @user.name = " "
    refute @user.valid?
  end

  test "user with empty email is invalid" do
    @user.email = ""
    refute @user.valid?

    @user.email = nil
    refute @user.valid?

    @user.email = " "
    refute @user.valid?
  end

  test "user name is shorter than 51" do
    @user.name = 'a' * 51
    refute @user.valid?
  end

  test "user email is shorter than 255" do
    @user.email = 'a' * (256 - '@gmail.com'.length) + '@gmail.com'
    refute @user.valid?
  end

  test "users with valid email addresses are valid" do
    valid_emails = %w[abc@gmail.com
      ab_c@gmail.com
      ab+c@gmail.com
      aB-c@gmail.com
      ab.c@gmail.com
      abc@foo.bar.biz]

    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "user with email #{email.inspect} should be valid."
    end
  end

  test "users with invalid email addresses are invalid" do
    valid_emails = %w[abc@gmail,com
      abc_at_gmail.com
      abc@gma+il.com
      abc@gma_il.com
      abc@gmail..com]

    valid_emails.each do |email|
      @user.email = email
      refute @user.valid?, "user with email #{email.inspect} should be invalid."
    end
  end

  test "users must have unique email addresses to be valid" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    refute duplicate_user.valid?
  end
end

# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(email: "test@test.com",
                     username: "test",
                     password: "password",
                     password_confirmation: "password")
  end

  test "username should be present, between 3 and 15 chars" do
    assert @user.valid?
    @user.username = nil
    assert_not @user.valid?
    @user.username = "a" * 2
    assert_not @user.valid?
    @user.username = "a" * 16
    assert_not @user.valid?
  end

  test "username should unique, case insensitive" do
    @user.username = User.first.username.swapcase
    assert_not @user.valid?
  end

  test "username should match a pattern" do
    @user.username = "_test"
    assert_not @user.valid?
    @user.username = "test!"
    assert_not @user.valid?
    @user.username = "t__est"
    assert_not @user.valid?
  end
end

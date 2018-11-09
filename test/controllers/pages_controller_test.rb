# frozen_string_literal: true

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "should get about" do
    get about_url
    assert_response :success
  end

  test "should get tos" do
    get tos_url
    assert_response :success
  end

  test "should get contact" do
    get contact_url
    assert_response :success
  end

end

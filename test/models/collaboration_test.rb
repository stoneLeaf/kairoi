require 'test_helper'

class CollaborationTest < ActiveSupport::TestCase

  def setup
    @user = users(:holden)
    @project = projects(:galileo)
    @collaboration = collaborations(:holden_leads_galileo)
  end

  test "should have a user" do
    @collaboration.user = nil
    assert_not @collaboration.valid?
  end

  test "should have a project" do
    @collaboration.project = nil
    assert_not @collaboration.valid?
  end

  test "should have a nature" do
    @collaboration.nature = nil
    assert_not @collaboration.valid?
  end
end

# frozen_string_literal: true

require 'test_helper'

class CollaborationTest < ActiveSupport::TestCase

  def setup
    @project = projects(:galileo)
    @user = users(:naomi)
    @collaboration = collaborations(:naomi_leads_galileo)
  end

  test "user is not optional" do
    @collaboration.user = nil
    assert_not @collaboration.valid?
  end

  test "user unique in project scope" do
    new_collab = @project.collaborations.build(user: @user,
                                               nature: Collaboration.natures[:manager])
    assert_not new_collab.valid?
  end

  test "project is not optional" do
    @collaboration.project = nil
    assert_not @collaboration.valid?
  end

  test "should have a nature" do
    @collaboration.nature = nil
    assert_not @collaboration.valid?
  end
end

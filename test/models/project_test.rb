require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    @project = projects(:galileo)
  end

  test "name should be present and 160 chars max" do
    @project.name = ""
    assert_not @project.valid?
    @project.name = "a" * 161
    assert_not @project.valid?
    @project.name = "a" * 50
    assert @project.valid?
  end
end

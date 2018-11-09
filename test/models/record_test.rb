require 'test_helper'

class RecordTest < ActiveSupport::TestCase

  def setup
    @user = users(:holden)
    @project = projects(:galileo)
    @record = Record.new(user: @user, project: @project, start_date: Time.now)
  end

  test "basic presence validation" do
    assert_not @record.update_attributes(user: nil)
    assert_not @record.update_attributes(project: nil)
    assert_not @record.update_attributes(start_date: nil)
  end

  test "end_date should be after start_date" do
    assert @record.update_attributes(end_date: @record.start_date + 1.hour)
    assert_not @record.update_attributes(end_date: @record.start_date - 1.hour)
  end
end

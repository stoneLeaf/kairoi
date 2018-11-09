require 'test_helper'

class RecordTest < ActiveSupport::TestCase

  def setup
    @user = users(:holden)
    @project = projects(:galileo)
    @record = Record.new(user: @user, project: @project, start_date: Time.now)
  end

  test "should be valid" do
    assert @record.valid?
  end

  test "end_date should be after start_date" do
    @record.update_attribute(:end_date, @record.start_date + 1.hour)
    assert @record.valid?
    @record.update_attribute(:end_date, @record.start_date - 1.hour)
    assert_not @record.valid?
  end
end

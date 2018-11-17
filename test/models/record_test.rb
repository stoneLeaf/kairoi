# frozen_string_literal: true

require 'test_helper'

class RecordTest < ActiveSupport::TestCase

  def setup
    @user = users(:holden)
    @project = projects(:galileo)
    @record = Record.new(user: @user, project: @project, start_date: Time.now)
  end

  test "user is not optional" do
    @record.user = nil
    assert_not @record.valid?
  end

  test "project is not optional" do
    @record.project = nil
    assert_not @record.valid?
  end

  test "should have a start_date" do
    @record.start_date = nil
    assert_not @record.valid?
  end

  test "end_date should be after start_date" do
    assert @record.update_attributes(end_date: @record.start_date + 1.hour)
    assert_not @record.update_attributes(end_date: @record.start_date - 1.hour)
  end
end

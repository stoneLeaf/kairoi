# frozen_string_literal: true

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
    assert @project.valid?, @project.errors.full_messages.inspect
  end

  test "name should be unique in owner's scope" do
    new_project = @project.owner.projects.build(name: @project.name)
    assert_not new_project.valid?
  end

  test "slug should be 70 chars max" do
    @project.name = "a" * 71
    assert @project.valid?
    assert @project.slug.length == 70
  end

  test "slug should be unique in owner's scope" do
    new_project = @project.owner.projects.build(name: @project.name + "$")
    assert_not new_project.valid?
  end

  test "owner should not be optional" do
    @project.owner = nil
    assert_not @project.valid?
  end

  test "owner has all rights" do
    assert @project.member_rights?(@project.owner)
    assert @project.manager_rights?(@project.owner)
    assert @project.lead_rights?(@project.owner)
  end

  test "member has member rights" do
    assert @project.member_rights?(@project.members.first)
  end

  test "manager has manager rights" do
    assert @project.manager_rights?(@project.managers.first)
  end

  test "lead has lead rights" do
    assert @project.lead_rights?(@project.leads.first)
  end
end

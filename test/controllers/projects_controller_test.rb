require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @first_user = users(:holden)
    @second_user = users(:miller)
    @first_user_project = projects(:galileo)
    @second_user_project = projects(:figaro)
  end

  test "only leads can delete their projects" do
    # Non logged in
    delete project_url(@first_user_project.to_param)
    assert Project.exists?(@first_user_project.id)
    # Not a lead
    sign_in @second_user
    delete project_url(@first_user_project.to_param)
    assert Project.exists?(@first_user_project.id)
    # As lead
    sign_in @first_user
    delete project_url(@first_user_project.to_param)
    assert_not Project.exists?(@first_user_project.id)
  end

  test "only show projects to members" do
    # Non logged in
    get project_url(@first_user_project.to_param)
    assert_redirected_to new_user_session_url
    # Not a member
    sign_in @first_user
    get project_url(@second_user_project.to_param)
    assert_redirected_to root_url
    # As lead
    get project_url(@first_user_project.to_param)
    assert_response :success
  end
end

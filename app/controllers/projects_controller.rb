# frozen_string_literal: true

# Controller for Projects
class ProjectsController < ApplicationController
  before_action :set_project, except: %i[index new create]
  before_action :members_only, only: :show
  before_action :managers_only, only: %i[edit update]
  before_action :leads_only, only: :destroy

  rescue_from ActiveRecord::RecordNotFound, with: :handle_project_not_found

  def index; end

  def new; end

  def create; end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def members_only
    raise Exceptions::ActionDeniedError unless @project.member_rights?(current_user)
  end

  def managers_only
    raise Exceptions::ActionDeniedError unless @project.manager_rights?(current_user)
  end

  def leads_only
    raise Exceptions::ActionDeniedError unless @project.lead_rights?(current_user)
  end

  def handle_project_not_found
    flash[:danger] = "Project not found."
    redirect_to projects_url and return
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
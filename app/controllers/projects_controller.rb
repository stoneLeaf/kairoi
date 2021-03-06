# frozen_string_literal: true

# Controller for Projects
class ProjectsController < ApplicationController
  before_action :set_project, except: %i[index new create]
  before_action :members_only, only: :show
  before_action :managers_only, only: %i[edit update]
  before_action :leads_only, only: :destroy

  rescue_from ActiveRecord::RecordNotFound, with: :handle_project_not_found

  def index; end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      flash[:success] = "Project created!"
      redirect_to project_url(@project.to_param)
    else
      render 'new'
    end
  end

  def show
    @last_records = Record.where(project: @project).order("start_date DESC").limit(5)
    @record = Record.new
  end

  def edit; end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated!"
      redirect_to project_url(@project.to_param)
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    flash[:success] = "Project deleted."
    redirect_to projects_url
  end

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
    @owner = User.find_by_username(params[:project_namespace])
    raise ActiveRecord::RecordNotFound if @owner.nil?

    @project = Project.where(owner: @owner, slug: params[:project_slug]).first
    raise ActiveRecord::RecordNotFound if @project.nil?
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
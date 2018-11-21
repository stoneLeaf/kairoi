# frozen_string_literal: true

# Controller for Records
class RecordsController < ApplicationController
  before_action :not_already_recording, only: [:create]
  before_action :set_project_owner, only: [:create]
  before_action :set_project, only: [:create]
  before_action :only_project_members, only: [:create]

  before_action :set_record, only: [:destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def create
    @record = current_user.records.build(project: @project,
                                         start_date: Time.now)
    flash[:danger] = "Could not create the record." unless @record.save
    redirect_to project_url(@project.to_param)
  end

  def stop
    @record = current_user.current_record
    raise ActiveRecord::RecordNotFound if @record.nil?

    @record.update_attribute(:end_date, Time.now)
    redirect_to project_url(@record.project.to_param)
  end

  def destroy
    @record.destroy
    redirect_to project_url(@record.project.to_param)
  end

  private

  def not_already_recording
    raise Exceptions::ActionDeniedError if current_user.recording?
  end

  def set_project_owner
    @project_owner = User.find_by_username(params[:record][:project_namespace])
    handle_project_not_found if @project_owner.nil?
  end

  def set_project
    @project = Project.where(owner: @project_owner,
                             slug: params[:record][:project_slug]).first
    handle_project_not_found if @project.nil?
  end

  def only_project_members
    raise Exceptions::ActionDeniedError unless @project.member_rights?(current_user)
  end

  def set_record
    @record = Record.find(params[:id])
    raise Exceptions::ActionDeniedError unless @record.user == current_user
  end

  def record_params
    params.require(:record).permit(:project_namespace, :project_slug)
  end

  def handle_project_not_found
    flash[:danger] = "Project not found."
    redirect_to root_url and return
  end

  def handle_record_not_found
    flash[:danger] = "Record not found."
    redirect_to root_url and return
  end
end

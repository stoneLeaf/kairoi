# frozen_string_literal: true

# Base controller class
class ApplicationController < ActionController::Base
  before_action :set_layout_instance_variables
  rescue_from Exceptions::ActionDeniedError, with: :handle_action_denied

  private

  def set_layout_instance_variables
    @projects = current_user.projects if user_signed_in?
  end

  def handle_action_denied
    flash[:danger] = "Action denied."
    redirect_to root_url and return
  end
end
# frozen_string_literal: true

# Base controller class
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_layout_instance_variables
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Exceptions::ActionDeniedError, with: :handle_action_denied

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  private

  def set_layout_instance_variables
    @projects = current_user.projects.reject(&:new_record?) if user_signed_in?
  end

  def handle_action_denied
    flash[:danger] = "Action denied."
    redirect_to root_url and return
  end
end
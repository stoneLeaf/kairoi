# frozen_string_literal: true

# Static pages controller
class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home; end

  def about; end

  def features; end

  def tos; end

  def contact; end
end

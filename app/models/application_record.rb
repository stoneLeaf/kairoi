# frozen_string_literal: true

# Base model class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def to_slug(input)
    input.parameterize.truncate(70, omission: "")
  end
end

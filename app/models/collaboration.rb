# frozen_string_literal: true

class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum nature: { lead: 0, manager: 1, member: 2 } # could use a separate model

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :nature, presence: true
end

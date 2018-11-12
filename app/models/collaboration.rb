# frozen_string_literal: true

# Collaboration model
#
# @attr nature [Enum] the collaboration's nature
class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum nature: { lead: 0, manager: 1, member: 2 } # could use a separate model

  validates :user, presence: true, uniqueness: { scope: :project }
  validates :project, presence: true
  validates :nature, presence: true
end

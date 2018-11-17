# frozen_string_literal: true

# Collaboration model
#
# @attr nature [Enum] the collaboration's nature
class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum nature: { lead: 0, manager: 1, member: 2 } # could use a separate model

  validates :user, uniqueness: { scope: :project }
  validates :nature, presence: true
end

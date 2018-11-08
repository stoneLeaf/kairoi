class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum type: { lead: 0, manager: 1, member: 2 } # could use a separate model collaborations_types

  validates :user_id, presence: true
  validates :project_id, presence: true
end

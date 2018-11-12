# frozen_string_literal: true

# Project model
#
# @attr name [String] the project's name (required)
class Project < ApplicationRecord
  has_many :collaborations
  has_many :users, through: :collaborations
  has_many :records

  validates :name, presence: true, length: { maximum: 160 }

  def members
    users_with_nature Collaboration.natures[:member]
  end

  def managers
    users_with_nature Collaboration.natures[:manager]
  end

  def leads
    users_with_nature Collaboration.natures[:lead]
  end

  def member_rights?(user)
    users.exists? user.id
  end

  def manager_rights?(user)
    managers.or(leads).exists? user.id
  end

  def lead_rights?(user)
    leads.exists? user.id
  end

  private

  def users_with_nature(nature)
    # TODO: find a way not to hard code the column name
    users.where("collaborations.nature = ?", nature)
  end
end

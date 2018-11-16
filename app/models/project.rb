# frozen_string_literal: true

# Project model
#
# @attr name [String] the project's name (required)
class Project < ApplicationRecord
  has_many :collaborations, dependent: :destroy
  has_many :users, through: :collaborations
  has_many :records, dependent: :destroy
  belongs_to :owner, polymorphic: true

  validates :name, presence: true, length: { minimum: 2, maximum: 160 }, uniqueness: { scope: :owner}
  validates :owner, presence: true

  def members
    users.merge(Collaboration.member)
  end

  def managers
    users.merge(Collaboration.manager)
  end

  def leads
    users.merge(Collaboration.lead)
  end

  def member_rights?(user)
    user == owner || users.exists?(user.id)
  end

  def manager_rights?(user)
    user == owner || managers.or(leads).exists?(user.id)
  end

  def lead_rights?(user)
    user == owner || leads.exists?(user.id)
  end
end

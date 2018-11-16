# frozen_string_literal: true

# Project model
#
# @attr name [String] the project's name (required)
class Project < ApplicationRecord
  has_many :collaborations, dependent: :destroy
  has_many :users, through: :collaborations
  has_many :records, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  validates :name, presence: true, length: { maximum: 160 }

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
    users.exists? user.id
  end

  def manager_rights?(user)
    managers.or(leads).exists? user.id
  end

  def lead_rights?(user)
    leads.exists? user.id
  end
end

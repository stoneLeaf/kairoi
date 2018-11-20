# frozen_string_literal: true

# Project model
#
# @attr name [String] the project's name (required)
class Project < ApplicationRecord
  has_many :collaborations, dependent: :destroy
  has_many :users, through: :collaborations
  has_many :records, dependent: :destroy
  belongs_to :owner, polymorphic: true

  validates :name, presence: true, length: { maximum: 160 },
                   uniqueness: { scope: :owner }
  before_validation :generate_slug
  validates :slug, presence: true, length: { maximum: 70 },
                   uniqueness: { scope: :owner,
                                 message: "path already used in namespace" }

  # Override ActiveRecord::Base to_param
  # TODO: Is there a way to make it called automatically by routes helpers?
  def to_param
    { owner_name: owner.username, slug: slug }
  end

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

  private

  def generate_slug
    self.slug = to_slug(name)
  end
end

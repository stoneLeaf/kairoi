# frozen_string_literal: true

# User model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :projects, as: :owner
  has_many :collaborations, dependent: :destroy
  has_many :indirect_projects, through: :collaborations, source: :projects
  has_many :records, dependent: :destroy

  validates :username, presence: true, length: { minimum: 3, maximum: 15 },
                       format: { with: /\A(?!_)(?!.*?__)[\w]{3,}\z/ },
                       uniqueness: { case_sensitive: false }
end

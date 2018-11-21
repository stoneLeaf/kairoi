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
                       uniqueness: { case_sensitive: false }
  validates_format_of :username,
                      with: /\A\w+\z/,
                      message: "must be alphanumeric and underscores only"
  validates_format_of :username,
                      with: /\A(?!_)/,
                      message: "cannot start by an underscore"
  validates_format_of :username,
                      with: /\A(?!.*?__).+\z/,
                      message: "cannot have consecutive underscores"

  def recording?
    records.where(end_date: nil).any?
  end

  def current_record
    records.where(end_date: nil).first
  end
end

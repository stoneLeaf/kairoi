# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :start_date, presence: true
  validate :end_after_start

  def end_after_start
    if end_date.present? && end_date <= start_date
      errors.add(:end_date, "must be after start_date")
    end
  end
end

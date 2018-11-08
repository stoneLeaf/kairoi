class Record < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :start, presence: true
  validate :end_after_start

  def end_after_start
    # 
  end
end

# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :users, through: :collaborations
  has_many :records

  validates :name, presence: true, length: { maximum: 160 }
end

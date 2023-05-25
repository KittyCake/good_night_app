class SleepRecord < ApplicationRecord
  belongs_to :user

  validates :started_at, presence: true
  validates :ended_at, presence: true
end

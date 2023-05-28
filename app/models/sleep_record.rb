class SleepRecord < ApplicationRecord
  validates :started_at, :ended_at, presence: true
  validate :end_after_start

  belongs_to :user

  def duration
    ended_at - started_at
  end

  private

  def end_after_start
    return if ended_at.blank? || started_at.blank?

    if ended_at < started_at
      errors.add(:ended_at, 'must be after started_at')
    end
  end
end

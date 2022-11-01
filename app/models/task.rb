class Task < ApplicationRecord
  enum priolity: { low: 0, middle: 1, high: 2, top: 3 }
  enum status: { waiting: 0, working: 1, completed: 2 }
  validates :name,  presence: true, length: { maximum: 32}
  validates :note, presence: true, length: { maximum: 1024}
  validates :expired_at, presence: true
  validate :after_today


  def after_today
    return if expired_at.blank?
    errors.add(:expired_at,"は今日以降のものを選択してください")if expired_at < Date.today
  end
end

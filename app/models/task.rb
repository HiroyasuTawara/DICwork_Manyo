class Task < ApplicationRecord
  enum priolity: { low: 0, middle: 1, high: 2, top: 3 }
  enum status: { waiting: 0, working: 1, completed: 2 }
  validates :name,  presence: true, length: { maximum: 32}
  validates :note, presence: true, length: { maximum: 1024}
end

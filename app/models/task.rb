class Task < ApplicationRecord
  enum priolity: { 低: 0, 中: 1, 高: 2, 最優先: 3 }
  enum status: { 未着手: 0, 着手: 1, 完了: 2 }

  belongs_to :user
  has_many :label_tasks, dependent: :destroy
  has_many :labels, through: :label_tasks
  
  validates :name,  presence: true, length: { maximum: 32}
  validates :note, presence: true, length: { maximum: 1024}
  validates :expired_at, presence: true
  validate :after_today

  def after_today
    return if expired_at.blank?
    errors.add(:expired_at,"は今日以降のものを選択してください")if expired_at < Date.today
  end

  scope :sort_expired_at, -> { order("expired_at ASC") }
  scope :sort_priolity, -> { order("priolity DESC") }
  scope :sort_created_at, -> { order("created_at DESC") }


  scope :search_status, ->(status) {
    return if status.blank?
    where(status: status) }
  scope :search_name, ->(name) {
    return if name.blank?
    where('name LIKE ?',"%#{name}%") }
    scope :search_label, ->(label) {
      return if label.blank?
      where(id: LabelTask.where(label_id: label).select(:task_id))}

end

class Label < ApplicationRecord
  enum color: { red: 0, green: 1, blue: 2, gray: 3, snow: 4, cyan: 5, magenta: 6, yellow:7 }
  belongs_to :user
  has_many :label_tasks
  has_many :users, through: :label_tasks

  validates :name, presence: true
end

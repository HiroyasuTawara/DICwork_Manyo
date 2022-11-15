class Label < ApplicationRecord
  enum color: { orangered: 0, mediumseagreen: 1, royalblue: 2, darkorange: 3, lightslategray: 4, hotpink: 5 }

  belongs_to :user
  has_many :label_tasks, dependent: :destroy
  has_many :users, through: :label_tasks
  validates :name, presence: true
end

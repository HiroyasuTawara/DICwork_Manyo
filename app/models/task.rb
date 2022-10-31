class Task < ApplicationRecord
  enum priolity: { low: 0, middle: 1, high: 2, top: 3 }
  enum status: { waiting: 0, working: 1, completed: 2 }

  PRIOLITY = {
    low: "低",
    middle: "中",
    high: "高",
    top: "最優先"
  }

  STATUS = {
    waiting: "未着手",
    working: "着手",
    completed: "完了",
  }
  #enum :status, { 未着手: 0, 着手: 1, 完了: 2 }
  #enum :priolity, %i("低" "中" "高" "最優先" "済")
  #enum :status, %i("未着手" "着手" "完了")
end

FactoryBot.define do
  factory :label do
    name { "ラベルテスト" }
    color { 0 }
  end

  factory :first_label, class: Label do
    name { 'ラベル1' }
    color { 1 }
  end

  factory :second_label, class: Label do
    name { 'ラベル2' }
    color { 2 }
  end
end
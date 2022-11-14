FactoryBot.define do
  factory :label do
    name { "ラベルテスト" }
  end

  factory :first_label, class: Label do
    name { 'ラベル1' }
  end

  factory :second_label, class: Label do
    name { 'ラベル2' }
  end
end
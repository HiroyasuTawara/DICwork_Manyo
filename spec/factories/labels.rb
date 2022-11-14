FactoryBot.define do
  factory :label do
    name { "ラベルテスト" }
  end

  factory :first_label, class: Label do
    name { 'ラベル1' }
    user_id { }
  end

  factory :second_label, class: Label do
    name { 'ラベル2' }
    user_id { }
  end
end
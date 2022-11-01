FactoryBot.define do
  factory :task do
    name {"name"}
    priolity {1}
    status {1}
    note {"note"}   
  end
  factory :second_task do
    name {"name2"}
    note {"note2"}   
  end
end

FactoryBot.define do
  factory :task do
    name {"name_chiken"}
    priolity {1}
    status {1}
    note {"note"}
    created_at { '2032/10/01' }
    expired_at{ '2032/11/01' }
    user_id {1}
  end
  factory :second_task, class: Task do
    name {"name_2_cat"}
    priolity {2}
    status {0}
    note {"note_2"}
    created_at { '2032/10/02' }
    expired_at{ '2032/10/31' }
    user_id {1}
  end
  factory :third_task, class: Task do
    name {"name_3_dog"}
    priolity {0}
    status {0}
    note {"note_3"}
    created_at { '2032/10/03' }
    expired_at{ '2032/11/02' }
    user_id {1}
  end
  factory :fourth_task, class: Task do
    name {"name_4_donkey"}
    priolity {3}
    status {2}
    note {"note_4"}
    created_at { '2032/10/04' }
    expired_at{ '2032/11/03' }
    user_id {1}
  end
end

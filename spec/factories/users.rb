FactoryBot.define do
  factory :admin_user, class: User do
    id {20}
    name { "管理者ユーザー" }
    email { "administar@sample.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { true }
  end

  factory :normal_user, class: User do
    id {1}
    name { "一般ユーザー" }
    email { "normal@sample.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { false }
  end

  factory :first_user, class: User do
    name { "hogehoge" }
    email { "hogehoge@sample.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { false }
  end

  factory :second_user, class: User do
    name { "fugafuga" }
    email { "fugafuga@sample.com" }
    password { "123456" }
    password_confirmation { "123456" }
    admin { true }
  end
end

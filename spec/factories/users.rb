FactoryBot.define do
  factory :user do
    full_name { Faker::FunnyName.name_with_initial }
    email { Faker::Internet.email }
  end
end

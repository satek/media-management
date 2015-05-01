FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password USER_TEST_PASSWORD

    trait :admin do
      role 'admin'
    end
  end
end

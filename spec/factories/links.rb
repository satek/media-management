FactoryGirl.define do
  factory :link do
    url { Faker::Internet.url }
    media_item { FactoryGirl.create :link_item }
  end
end

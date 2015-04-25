FactoryGirl.define do
  factory :link do
    url { Faker::Internet.url }

    factory :video_link do
      type "VideoLink"
      media_item_id { FactoryGirl.create(:video_item).id }
    end

    factory :web_link do
      type "WebLink"
      media_item_id { FactoryGirl.create(:link_item).id }
    end
  end
end

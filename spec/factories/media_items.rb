FactoryGirl.define do
  factory :media_item do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }

    factory :video_item do
      type "VideoItem"
    end

    factory :link_item do
      type "LinkItem"
    end

    factory :image_item do
      type "ImageItem"
    end
  end
end

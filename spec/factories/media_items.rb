FactoryGirl.define do
  factory :media_item do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    user_id { FactoryGirl.create(:user).id }

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

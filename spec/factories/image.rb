include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :image do
    image_item { FactoryGirl.create :image_item }
    image {
      fixture_file_upload Rails.root.join('spec', 'factories', 'files', 'test.png'), 
                          "image/png"
    }
  end
end

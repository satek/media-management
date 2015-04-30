require "spec_helper"

describe Image do
  
  context "when built from factory" do
    subject { FactoryGirl.create :image }
    it { is_expected.to be_valid }
  end

  context "when image not present" do
    subject { FactoryGirl.build :image, image: nil }
    it "has an error on image field" do
      is_expected.to have(1).error_on(:image)
    end
  end
  
  context "when image item not present" do
    subject { FactoryGirl.build :image, image_item_id: nil }
    it "has an error on image item field" do
      is_expected.to have(1).error_on(:image_item_id)
    end
  end

end

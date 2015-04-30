require 'rails_helper'

RSpec.describe ImageItem, type: :model do

  context "when built from factory" do
    subject { FactoryGirl.build :image_item }
    it { is_expected.to be_valid }
  end

  describe "#has_images?" do
    let(:image_item) { FactoryGirl.create :image_item }
    subject { image_item }
    context "when image belongs to it" do
      let(:image) { FactoryGirl.create :image, image_item_id: subject.id }
      it "returns true" do
        image.reload
        expect(subject.has_images?).to be true
      end
    end
    context "when no image belongs to it" do
      it "returns false" do
        expect(subject.has_images?).to be false
      end
    end
  end

end

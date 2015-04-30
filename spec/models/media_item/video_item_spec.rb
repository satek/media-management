require 'rails_helper'

RSpec.describe VideoItem, type: :model do

  context "when built from factory" do
    subject { FactoryGirl.build :video_item }
    it { is_expected.to be_valid }
  end

  describe "#has_link?" do
    let(:video_item) { FactoryGirl.create :video_item }
    subject { video_item }
    context "when link belongs to it" do
      let(:link) { FactoryGirl.create :link, media_item_id: video_item.id }
      it "returns true" do
        link.reload
        expect(subject.has_link?).to be true
      end
    end
    context "when no link belongs to it" do
      it "returns false" do
        expect(subject.has_link?).to be false
      end
    end
  end

end

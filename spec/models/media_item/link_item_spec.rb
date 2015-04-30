require 'rails_helper'

RSpec.describe LinkItem, type: :model do

  context "when built from factory" do
    subject { FactoryGirl.build :link_item }
    it { is_expected.to be_valid }
  end

  describe "#has_links?" do
    let(:link_item) { FactoryGirl.create :link_item }
    subject { link_item }
    context "when link belongs to it" do
      let(:link) { FactoryGirl.create :link, media_item_id: link_item.id }
      it "returns true" do
        link.reload
        expect(subject.has_links?).to be true
      end
    end
    context "when no link belongs to it" do
      it "returns false" do
        expect(subject.has_links?).to be false
      end
    end
  end
end

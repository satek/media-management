require 'rails_helper'

RSpec.describe Link, type: :model do

  context "when factory loaded" do
    subject { FactoryGirl.build :link }
    it "should be valid" do
      is_expected.to be_valid
    end
  end

  context "when media item not set" do
    subject { FactoryGirl.build :link, media_item_id: nil }
    it "should be invalid" do
      subject.valid?
      is_expected.to have(1).errors_on(:media_item_id)
    end
  end
  
  context "when url protocol is missing" do
    subject { FactoryGirl.build :link, url: "url-without-protocol" }
    it "should be invalid" do
      subject.valid?
      is_expected.to have(1).errors_on(:url)
    end
  end
  
  context "when url is missing" do
    subject { FactoryGirl.build :link, url: nil }
    it "should be invalid" do
      subject.valid?
      is_expected.to have(1).errors_on(:url)
    end
  end
end

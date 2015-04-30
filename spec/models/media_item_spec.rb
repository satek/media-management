require 'rails_helper'

RSpec.describe MediaItem, type: :model do

  context "when created from factory" do
    subject { FactoryGirl.build :media_item }
    it "is has error on type" do
      is_expected.to have(1).errors_on :type 
    end
  end

  context "when required fields are missing" do
    let(:fields) { { title: nil, description: nil, user_id: nil } }
    subject { 
      FactoryGirl.build :media_item, fields
    }
    it "is has errors for required fields" do
      fields.keys.each { |field|
        is_expected.to have(1).errors_on field
      }
    end
  end

  context "when type is invalid" do
    subject { FactoryGirl.build :media_item, type: "invalid" }
    it { is_expected.to have(1).error_on :type }
  end
  
end

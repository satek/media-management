require 'rails_helper'

RSpec.describe MediaItem, type: :model do

  before(:each) { 
    @media_item = FactoryGirl.build :media_item
  }

  it "is invalid without a type" do
    expect(@media_item).not_to be_valid
  end

  it "belongs to a user" do
    @media_item.user_id = nil
    @media_item.valid?
    expect(@media_item.errors.messages[:user_id]).not_to be_nil
  end

end

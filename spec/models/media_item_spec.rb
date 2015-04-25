require 'rails_helper'

RSpec.describe MediaItem, type: :model do

  before(:each) { 
    @media_item = FactoryGirl.build :media_item
    @video_item = FactoryGirl.build :video_item
    @link_item = FactoryGirl.build :link_item
    @image_item = FactoryGirl.build :image_item
  }

  it "is invalid without a type" do
    expect(@media_item).not_to be_valid
  end

  it "has a valid factories" do
    expect(@video_item).to be_valid
    expect(@link_item).to be_valid
    expect(@image_item).to be_valid
  end

end

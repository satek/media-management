require 'rails_helper'

RSpec.describe VideoItem, type: :model do

  before(:each) { 
    @video_item = FactoryGirl.build :video_item
  }

  it "has a valid factory" do
    expect(@video_item).to be_valid
  end

  it "is invalid without title" do
    @video_item.title = ''
    expect(@video_item).not_to be_valid
  end

  it "is invalid without description" do
    @video_item.description = ''
    expect(@video_item).not_to be_valid
  end

end

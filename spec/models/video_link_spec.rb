require 'rails_helper'

RSpec.describe VideoLink, type: :model do

  before(:each) { 
    @video_link = FactoryGirl.build :video_link
  }

  it "has a valid factory" do
    expect(@video_link).to be_valid
  end

  it "is invalid without a url" do
    @video_link.url = ''
    expect(@video_link).not_to be_valid
  end

end

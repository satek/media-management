require 'rails_helper'

RSpec.describe MediaItem, type: :model do

  before(:each) { 
    @media_item = FactoryGirl.build :media_item
  }

  it "is invalid without a type" do
    expect(@media_item).not_to be_valid
  end

end

require 'rails_helper'

RSpec.describe Link, type: :model do

  before(:each) { 
    @link = FactoryGirl.build :link
  }

  it "is invalid without a type" do
    expect(@link).not_to be_valid
  end

  it "belongs to a media item" do
    @link.media_item_id = nil
    @link.valid?
    expect(@link.errors.messages[:media_item_id]).not_to be_nil
  end

end

require 'rails_helper'

RSpec.describe ImageItem, type: :model do

  before(:each) { 
    @image_item = FactoryGirl.build :image_item
  }

  it "has a valid factory" do
    expect(@image_item).to be_valid
  end

  it "is invalid without title" do
    @image_item.title = ''
    expect(@image_item).not_to be_valid
  end

  it "is invalid without description" do
    @image_item.description = ''
    expect(@image_item).not_to be_valid
  end

end

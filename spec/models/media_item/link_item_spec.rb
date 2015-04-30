require 'rails_helper'

RSpec.describe LinkItem, type: :model do

  before(:each) { 
    @link_item = FactoryGirl.build :link_item
  }

  it "has a valid factory" do
    expect(@link_item).to be_valid
  end

  it "is invalid without title" do
    @link_item.title = ''
    expect(@link_item).not_to be_valid
  end

  it "is invalid without description" do
    @link_item.description = ''
    expect(@link_item).not_to be_valid
  end

end

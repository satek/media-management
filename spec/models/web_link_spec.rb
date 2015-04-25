require 'rails_helper'

RSpec.describe WebLink, type: :model do

  before(:each) { 
    @web_link = FactoryGirl.build :web_link
  }

  it "has a valid factory" do
    expect(@web_link).to be_valid
  end

  it "is invalid without a url" do
    @web_link.url = ''
    expect(@web_link).not_to be_valid
  end

end

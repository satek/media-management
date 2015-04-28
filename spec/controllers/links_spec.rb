require "spec_helper"

RSpec.describe LinksController, type: :controller do

  describe "POST create" do
    it "creates a new link for video item" do
      attrs = FactoryGirl.attributes_for :link
      @video_item = FactoryGirl.create :video_item
      post :create, media_item_id: @video_item, 
                    link: attrs
      @video_item.reload
      expect(@video_item.link.url).to eq(attrs[:url])
      expect(response).to redirect_to(video_item_path(@video_item.id))
    end
  end
end

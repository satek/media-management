require "spec_helper"

RSpec.describe VideoItemsController, type: :controller do

  before(:each) do
    @video_item = FactoryGirl.create :video_item
    sign_in @video_item.user
  end
  
  describe "GET show" do
    it "assigns @item" do
      get :show, id: @video_item.id
      assigned = assigns(:video_item)
      expect(assigned.title).to eq(@video_item.title)
      expect(assigned.description).to eq(@video_item.description)
    end
  end

  describe "GET edit" do
    it "assigns @item" do
      get :edit, id: @video_item.id
      assigned = assigns(:video_item)
      expect(assigned.title).to eq(@video_item.title)
      expect(assigned.description).to eq(@video_item.description)
    end
  end

  describe "PUT update" do
    it "assigns and updates @item" do
      new_attrs = FactoryGirl.attributes_for :video_item
      put :update, id: @video_item.id, video_item: new_attrs.except(:type, :user_id)
      @video_item.reload
      expect(@video_item.title).to eq(new_attrs[:title])
      expect(@video_item.description).to eq(new_attrs[:description])
      expect(response).to redirect_to(video_item_path(@video_item.id))
    end
  end
end

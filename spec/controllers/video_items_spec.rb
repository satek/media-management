require "spec_helper"

RSpec.describe VideoItemsController, type: :controller do

  before(:each) do
    @video_item = FactoryGirl.create :video_item
  end
  
  describe "GET show" do
    it "assigns @item" do
      sign_in @video_item.user
      get :show, id: @video_item.id
      assigned = assigns(:video_item)
      expect(assigned.title).to eq(@video_item.title)
      expect(assigned.description).to eq(@video_item.description)
    end

    it "requires login" do
      get :show, id: @video_item.id
      assigned = assigns(:video_item)
      expect(assigned).to be_nil
    end

    it "allows only owner to see unpublished item" do
      non_owner = FactoryGirl.create :user
      sign_in non_owner
      get :show, id: @video_item.id
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET edit" do
    it "assigns @item" do
      sign_in @video_item.user
      get :edit, id: @video_item.id
      assigned = assigns(:video_item)
      expect(assigned.title).to eq(@video_item.title)
      expect(assigned.description).to eq(@video_item.description)
    end

    it "requires login" do
      get :edit, id: @video_item.id
      assigned = assigns(:video_item)
      expect(assigned).to be_nil
    end

    it "allows only owner to see unpublished item" do
      non_owner = FactoryGirl.create :user
      sign_in non_owner
      get :edit, id: @video_item.id
      expect(response).to redirect_to(root_path)
    end
  end

  describe "PUT update" do

    before(:each) do
      @new_attrs = FactoryGirl.attributes_for :video_item
    end

    it "assigns and updates @item" do
      sign_in @video_item.user
      put :update, id: @video_item.id, video_item: @new_attrs.except(:type, :user_id)
      @video_item.reload
      expect(@video_item.title).to eq(@new_attrs[:title])
      expect(@video_item.description).to eq(@new_attrs[:description])
      expect(response).to redirect_to(video_item_path(@video_item.id))
    end

    it "requires login" do
      get :edit, id: @video_item.id
      assigned = assigns(:video_item)
      expect(assigned).to be_nil
    end

    it "allows only owner to see unpublished item" do
      non_owner = FactoryGirl.create :user
      sign_in non_owner
      put :update, id: @video_item.id, video_item: @new_attrs.except(:type, :user_id)
      expect(response).to redirect_to(root_path)
    end
  end
end

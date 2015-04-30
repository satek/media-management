require "spec_helper"

RSpec.describe ImageItemsController, type: :controller do

  before(:each) do
    @image_item = FactoryGirl.create :image_item
  end
  
  describe "GET show" do
    it "assigns @item" do
      sign_in @image_item.user
      get :show, id: @image_item.id
      assigned = assigns(:image_item)
      expect(assigned.title).to eq(@image_item.title)
      expect(assigned.description).to eq(@image_item.description)
    end

    it "requires login" do
      get :show, id: @image_item.id
      assigned = assigns(:image_item)
      expect(assigned).to be_nil
    end

    it "allows only owner to see unpublished item" do
      non_owner = FactoryGirl.create :user
      sign_in non_owner
      get :show, id: @image_item.id
      expect(response).to redirect_to(root_path)
    end

    it "allows non-owner to see published item" do
      @image_item.update(published: true)
      non_owner = FactoryGirl.create :user
      sign_in non_owner
      get :show, id: @image_item.id
      assigned = assigns(:image_item)
      expect(assigned.title).to eq(@image_item.title)
      expect(assigned.description).to eq(@image_item.description)
    end
  end

  describe "GET edit" do
    it "assigns @item" do
      sign_in @image_item.user
      get :edit, id: @image_item.id
      assigned = assigns(:image_item)
      expect(assigned.title).to eq(@image_item.title)
      expect(assigned.description).to eq(@image_item.description)
    end

    it "requires login" do
      get :edit, id: @image_item.id
      assigned = assigns(:image_item)
      expect(assigned).to be_nil
    end

    it "allows only owner to see unpublished item" do
      non_owner = FactoryGirl.create :user
      sign_in non_owner
      get :edit, id: @image_item.id
      expect(response).to redirect_to(root_path)
    end
  end

  describe "PUT update" do

    before(:each) do
      @new_attrs = FactoryGirl.attributes_for :image_item
    end

    it "assigns and updates @item" do
      sign_in @image_item.user
      put :update, id: @image_item.id, image_item: @new_attrs.except(:type, :user_id)
      @image_item.reload
      expect(@image_item.title).to eq(@new_attrs[:title])
      expect(@image_item.description).to eq(@new_attrs[:description])
      expect(response).to redirect_to(image_item_path(@image_item.id))
    end

    it "requires login" do
      get :edit, id: @image_item.id
      assigned = assigns(:image_item)
      expect(assigned).to be_nil
    end

    it "allows only owner to see unpublished item" do
      non_owner = FactoryGirl.create :user
      sign_in non_owner
      put :update, id: @image_item.id, image_item: @new_attrs.except(:type, :user_id)
      expect(response).to redirect_to(root_path)
    end
  end
end

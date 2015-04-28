require "spec_helper"

RSpec.describe LinkItemsController, type: :controller do

  before(:each) do
    @link_item = FactoryGirl.create :link_item
  end
  
  describe "GET show" do
    it "assigns @item" do
      sign_in @link_item.user
      get :show, id: @link_item.id
      assigned = assigns(:link_item)
      expect(assigned.title).to eq(@link_item.title)
      expect(assigned.description).to eq(@link_item.description)
    end

    it "requires login" do
      get :show, id: @link_item.id
      assigned = assigns(:link_item)
      expect(assigned).to be_nil
    end

    it "allows only owner to see unpublished item" do
      non_owner = FactoryGirl.create :user
      sign_in non_owner
      get :show, id: @link_item.id
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET edit" do
    it "assigns @item" do
      sign_in @link_item.user
      get :edit, id: @link_item.id
      assigned = assigns(:link_item)
      expect(assigned.title).to eq(@link_item.title)
      expect(assigned.description).to eq(@link_item.description)
    end

    it "requires login" do
      get :edit, id: @link_item.id
      assigned = assigns(:link_item)
      expect(assigned).to be_nil
    end

    it "allows only owner to see unpublished item" do
      non_owner = FactoryGirl.create :user
      sign_in non_owner
      get :edit, id: @link_item.id
      expect(response).to redirect_to(root_path)
    end
  end

  describe "PUT update" do

    before(:each) do
      @new_attrs = FactoryGirl.attributes_for :link_item
    end

    it "assigns and updates @item" do
      sign_in @link_item.user
      put :update, id: @link_item.id, link_item: @new_attrs.except(:type, :user_id)
      @link_item.reload
      expect(@link_item.title).to eq(@new_attrs[:title])
      expect(@link_item.description).to eq(@new_attrs[:description])
      expect(response).to redirect_to(link_item_path(@link_item.id))
    end

    it "requires login" do
      get :edit, id: @link_item.id
      assigned = assigns(:link_item)
      expect(assigned).to be_nil
    end

    it "allows only owner to see unpublished item" do
      non_owner = FactoryGirl.create :user
      sign_in non_owner
      put :update, id: @link_item.id, link_item: @new_attrs.except(:type, :user_id)
      expect(response).to redirect_to(root_path)
    end
  end
end

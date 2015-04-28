require "spec_helper"

RSpec.describe LinkItemsController, type: :controller do

  before(:each) do
    @link_item = FactoryGirl.create :link_item
  end
  
  describe "GET show" do
    it "assigns @item" do
      get :show, id: @link_item.id
      assigned = assigns(:item)
      expect(assigned.title).to eq(@link_item.title)
      expect(assigned.description).to eq(@link_item.description)
    end
  end

  describe "GET edit" do
    it "assigns @item" do
      get :edit, id: @link_item.id
      assigned = assigns(:item)
      expect(assigned.title).to eq(@link_item.title)
      expect(assigned.description).to eq(@link_item.description)
    end
  end

  describe "PUT update" do
    it "assigns and updates @item" do
      new_attrs = FactoryGirl.attributes_for :link_item
      put :update, id: @link_item.id, link_item: new_attrs.except(:type, :user_id)
      @link_item.reload
      expect(@link_item.title).to eq(new_attrs[:title])
      expect(@link_item.description).to eq(new_attrs[:description])
      expect(response).to redirect_to(link_item_path(@link_item.id))
    end
  end
end

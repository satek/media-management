require "spec_helper"

RSpec.describe MediaItemsController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create :user
    @video_item = FactoryGirl.create :video_item, user: @user
    @link_item = FactoryGirl.create :link_item, user: @user
    @image_item = FactoryGirl.create :image_item, user: @user
  end

  describe "GET index" do
    it "requires login" do
      get :index
      expect(assigns(:media_items)).to be_nil
    end

    it "presents items that belong to current user" do
      sign_in @user
      get :index
      media_items = assigns(:media_items)
      expect(media_items.count).to be(3)
    end

    it "doesn't show unpublished items to non-owners" do
      sign_in FactoryGirl.create :user
      get :index
      media_items = assigns(:media_items)
      expect(media_items.count).to be(0)
    end

    it "shows published items to non-owners" do
      @video_item.update(published: true)
      sign_in FactoryGirl.create :user
      get :index
      media_items = assigns(:media_items)
      expect(media_items.count).to be(1)
    end
  end
end

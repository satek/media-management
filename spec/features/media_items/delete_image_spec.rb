require "spec_helper"

feature "delete image" do
  context "when not signed in" do
    let(:image) { FactoryGirl.create :image }
    scenario "deleting image" do
      page.driver.submit :delete, 
                         image_item_image_path(image.image_item.id, image.id), {}
      expect_not_signed_in page
      expect(Image.exists?(image.id)).to eq true
    end
  end

  context "when signed in" do
    let(:image) { FactoryGirl.create :image }
    scenario "deleting own image" do
      signin image.user.email
      page.driver.submit :delete, 
                         image_item_image_path(image.image_item.id, image.id), {}
      expect(page).to have_content("Image was successfully deleted")
      expect(Image.exists?(image.id)).to eq false
    end

    scenario "deleting own image via show image item", :js => true do
      signin image.user.email
      visit image_item_path(image.image_item.id)
      page.find("a[href='#{image_item_image_path(image.image_item.id, image.id)}']").click
      expect(page).to have_content("Image was successfully deleted")
      expect(Image.exists?(image.id)).to eq false
    end

    scenario "deleting another users image" do
      user = FactoryGirl.create :user
      signin user.email
      page.driver.submit :delete, 
                         image_item_image_path(image.image_item.id, image.id), {}
      expect_not_authorized page
      expect(current_path).to eq root_path
      expect(Image.exists?(image.id)).to eq true
    end
  end

end

require "spec_helper"

describe "edit image item" do
  context "when not signed in" do
    let(:image_item) { FactoryGirl.create :image_item }
    scenario "editing image item" do
      visit edit_image_item_path(image_item.id)
      expect_not_signed_in page
    end
  end
  
  context "when signed in" do
    let(:image_item) { FactoryGirl.create :image_item }
    let(:new_title) { "New title" }
    let(:new_description) { "New description" }
    
    scenario "editing their own image item" do
      signin image_item.user.email
      visit edit_image_item_path(image_item.id)
      expect(page).to have_content("Edit Image Item")
      expect(page).to have_content("Title")
      expect(page).to have_content("Description")
      expect(page).to have_css("input#image_item_title")
      expect(page).to have_css("textarea#image_item_description")
      fill_in "image_item_title", with: new_title
      fill_in "image_item_description", with: new_description
      check "image_item_published"
      click_button "Update Image item"
      image_item.reload
      expect(page).to have_content("Item was successfully updated")
      expect(image_item.title).to eq new_title
      expect(image_item.published?).to eq true
    end
    
    scenario "editing other user's image item" do
      user = FactoryGirl.create :user
      signin user.email
      visit edit_image_item_path(image_item.id)
      expect_not_authorized page
      expect(current_path).to eq root_path
    end
  end
end

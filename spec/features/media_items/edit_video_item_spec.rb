require "spec_helper"

describe "edit video item" do
  context "when not signed in" do
    let(:video_item) { FactoryGirl.create :video_item }
    scenario "editing video item" do
      visit edit_video_item_path(video_item.id)
      expect_not_signed_in page
    end
  end
  
  context "when signed in" do
    let(:video_item) { FactoryGirl.create :video_item }
    let(:new_title) { "New title" }
    let(:new_description) { "New description" }
    
    scenario "editing their own video item" do
      signin video_item.user.email
      visit edit_video_item_path(video_item.id)
      expect(page).to have_content("Edit Video Item")
      expect_edit_fields page
      fill_in "video_item_title", with: new_title
      fill_in "video_item_description", with: new_description
      click_button "Update Video item"
      video_item.reload
      expect(page).to have_content("Item was successfully updated")
      expect(video_item.title).to eq new_title
      expect(video_item.description).to eq new_description
    end

    scenario "editing other user's video item" do
      user = FactoryGirl.create :user
      signin user.email
      visit edit_video_item_path(video_item.id)
      expect_not_authorized page
      expect(current_path).to eq root_path
    end
  end
end

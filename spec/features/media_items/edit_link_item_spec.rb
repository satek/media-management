require "spec_helper"

describe "edit link item" do
  context "when not signed in" do
    let(:link_item) { FactoryGirl.create :link_item }
    scenario "editing link item" do
      visit edit_link_item_path(link_item.id)
      expect_not_signed_in page
    end
  end
  
  context "when signed in" do
    let(:link_item) { FactoryGirl.create :link_item }
    let(:new_title) { "New title" }
    let(:new_description) { "New description" }
    
    scenario "editing their own link item" do
      signin link_item.user.email
      visit edit_link_item_path(link_item.id)
      expect(page).to have_content("Edit Link Item")
      expect(page).to have_content("Title")
      expect(page).to have_content("Description")
      expect(page).to have_css("input#link_item_title")
      expect(page).to have_css("textarea#link_item_description")
      fill_in "link_item_title", with: new_title
      fill_in "link_item_description", with: new_description
      check "link_item_published"
      click_button "Update Link item"
      link_item.reload
      expect(page).to have_content("Item was successfully updated")
      expect(link_item.title).to eq new_title
      expect(link_item.description).to eq new_description
      expect(link_item.published?).to eq true
    end

    scenario "editing other user's link item" do
      user = FactoryGirl.create :user
      signin user.email
      visit edit_link_item_path(link_item.id)
      expect_not_authorized page
      expect(current_path).to eq root_path
    end
  end
end

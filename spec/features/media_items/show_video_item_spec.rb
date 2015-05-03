require "spec_helper"

feature "show video item" do
  context "when not signed in" do
    scenario "visiting video item show" do
      item = FactoryGirl.create :video_item
      visit video_item_path(item.id)
      expect(current_path).to eq(new_user_session_path)
      expect_not_signed_in page
    end
  end

  context "when signed in" do
    let(:item) { FactoryGirl.create :video_item }

    scenario "visiting other users unpublished item" do
      user = FactoryGirl.create :user
      signin user.email
      visit video_item_path(item.id)
      expect(current_path).to eq(root_path)
      expect_not_authorized page
    end

    context "when item doesn't have a link" do
      scenario "visiting own item" do
        signin item.user.email
        visit video_item_path(item.id)
        expect(current_path).to eq(video_item_path(item.id))
        expect_item_details page
        expect(page).to have_css("[@href='#{new_media_item_link_path(item.id)}']")
        expect(page).to have_css("[@href='#{edit_video_item_path(item.id)}']")
      end
      
      scenario "visiting other users published item" do
        item.update(published: true)
        user = FactoryGirl.create :user
        signin user.email
        visit video_item_path(item.id)
        expect(current_path).to eq(video_item_path(item.id))
        expect_item_details page
        expect(page).not_to have_css("[@href='#{edit_video_item_path(item.id)}']")
        expect(page).not_to have_content("View video")
      end

    end

    context "when item has a link" do
      scenario "visiting own item" do
        link = FactoryGirl.create :link, media_item_id: item.id
        signin item.user.email
        visit video_item_path(item.id)
        expect(current_path).to eq(video_item_path(item.id))
        expect_item_details page
        expect(page).to have_css("[@href='#{edit_media_item_link_path(item.id, link.id)}']")
        expect(page).to have_css("[@href='#{edit_video_item_path(item.id)}']")
        expect(page).to have_content("View video")
        expect(page).to have_css("[@href='#{item.link.url}']")
        expect(page).to have_css("embed[@src='#{item.link.url}']")
      end

      scenario "visiting other users published item" do
        item.update(published: true)
        user = FactoryGirl.create :user
        link = FactoryGirl.create :link, media_item_id: item.id
        signin user.email
        visit video_item_path(item.id)
        expect(current_path).to eq(video_item_path(item.id))
        expect_item_details page
        expect(page).not_to have_css("[@href='#{edit_media_item_link_path(item.id, link.id)}']")
        expect(page).not_to have_css("[@href='#{edit_video_item_path(item.id)}']")
        expect(page).to have_content("View video")
        expect(page).to have_css("[@href='#{item.link.url}']")
        expect(page).to have_css("embed[@src='#{item.link.url}']")
      end
    end
  end
end

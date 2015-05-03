require "spec_helper"

feature "show link item" do
  context "when not signed in" do
    scenario "visiting link item show" do
      item = FactoryGirl.create :link_item
      visit link_item_path(item.id)
      expect(current_path).to eq(new_user_session_path)
      expect_not_signed_in page
    end
  end

  context "when signed in" do
    let(:item) { FactoryGirl.create :link_item }

    scenario "visiting other users unpublished item" do
      user = FactoryGirl.create :user
      signin user.email
      visit link_item_path(item.id)
      expect(current_path).to eq(root_path)
      expect_not_authorized page
    end

    context "when item doesn't have any links" do
      scenario "visiting own item" do
        signin item.user.email
        visit link_item_path(item.id)
        expect(current_path).to eq(link_item_path(item.id))
        expect_item_details page
        expect(page).not_to have_content "Web Sites"
        expect(page).to have_css("[@href='#{new_media_item_link_path(item.id)}']")
        expect(page).to have_css("[@href='#{edit_link_item_path(item.id)}']")
      end
      
      scenario "visiting other users published item" do
        item.update(published: true)
        user = FactoryGirl.create :user
        signin user.email
        visit link_item_path(item.id)
        expect(current_path).to eq(link_item_path(item.id))
        expect_item_details page
        expect(page).not_to have_content "Web Sites"
        expect(page).not_to have_css("[@href='#{new_media_item_link_path(item.id)}']")
        expect(page).not_to have_css("[@href='#{edit_link_item_path(item.id)}']")
      end

    end

    context "when item has links" do
      before(:each) do
        @links = 3.times.map {
          FactoryGirl.create :link, media_item_id: item.id
        }
      end
      scenario "visiting own item" do
        signin item.user.email
        visit link_item_path(item.id)
        expect(current_path).to eq(link_item_path(item.id))
        expect_item_details page
        expect(page).to have_content "Web Sites"
        @links.each { |link|
          expect(page).to have_content("#{link.url}")
          expect(page).to have_css("[@href='#{link.url}']")
          expect(page).to have_css("[@href='#{edit_media_item_link_path(item.id, link.id)}']")
        }
        expect(page).to have_css("[@href='#{new_media_item_link_path(item.id)}']")
        expect(page).to have_css("[@href='#{edit_link_item_path(item.id)}']")
      end

      scenario "visiting other users published item" do
        item.update(published: true)
        user = FactoryGirl.create :user

        signin user.email
        visit link_item_path(item.id)
        expect(current_path).to eq(link_item_path(item.id))
        expect_item_details page
        expect(page).to have_content "Web Sites"
        @links.each { |link|
          expect(page).to have_content("#{link.url}")
          expect(page).to have_css("[@href='#{link.url}']")
          expect(page).not_to have_css("[@href='#{edit_media_item_link_path(item.id, link.id)}']")
        }
        expect(page).not_to have_css("[@href='#{new_media_item_link_path(item.id)}']")
        expect(page).not_to have_css("[@href='#{edit_link_item_path(item.id)}']")
      end
    end
  end
end

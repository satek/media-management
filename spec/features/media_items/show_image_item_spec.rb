require "spec_helper"

feature "show image item" do
  context "when not signed in" do
    scenario "visiting image item show" do
      item = FactoryGirl.create :image_item
      visit image_item_path(item.id)
      expect(current_path).to eq(new_user_session_path)
      expect_not_signed_in page
    end
  end

  context "when signed in" do
    let(:item) { FactoryGirl.create :image_item }

    scenario "visiting other users unpublished item" do
      user = FactoryGirl.create :user
      signin user.email
      visit image_item_path(item.id)
      expect(current_path).to eq(root_path)
      expect_not_authorized page
    end

    context "when item doesn't have any images" do
      scenario "visiting own item" do
        signin item.user.email
        visit image_item_path(item.id)
        expect(current_path).to eq(image_item_path(item.id))
        expect_item_details page
        expect(page).to have_content "Upload New Image"
        expect(page).not_to have_content "Images"
        expect(page).to have_css("[@href='#{edit_image_item_path(item.id)}']")
      end
      
      scenario "visiting other users published item" do
        item.update(published: true)
        user = FactoryGirl.create :user
        signin user.email
        visit image_item_path(item.id)
        expect(current_path).to eq(image_item_path(item.id))
        expect_item_details page
        expect(page).not_to have_content "Uploads New Image"
        expect(page).not_to have_content "Images"
        expect(page).not_to have_css("[@href='#{edit_image_item_path(item.id)}']")
      end
    end

    context "when item has images" do
      before(:each) do
        @images = 3.times.map {
          FactoryGirl.create :image, image_item_id: item.id
        }
      end
      scenario "visiting own item" do
        signin item.user.email
        visit image_item_path(item.id)
        expect(current_path).to eq(image_item_path(item.id))
        expect_item_details page
        expect(page).to have_content "Images"
        @images.each { |image|
          expect(page).to have_content("#{image.image_name}")
          expect(page).to have_css("[@src='#{image.image.thumb('400x200#').url}']")
          expect(page).to have_content("Delete")
        }
        expect(page).to have_content("Upload New Image")
        expect(page).to have_css("[@href='#{edit_image_item_path(item.id)}']")
      end

      scenario "visiting other users published item" do
        item.update(published: true)
        user = FactoryGirl.create :user
        signin user.email
        visit image_item_path(item.id)
        expect(current_path).to eq(image_item_path(item.id))
        expect_item_details page
        expect(page).to have_content "Images"
        @images.each { |image|
          expect(page).to have_content("#{image.image_name}")
          expect(page).to have_css("[@src='#{image.image.thumb('400x200#').url}']")
          expect(page).not_to have_content("Delete")
        }
        expect(page).not_to have_css("[@href='#{edit_image_item_path(item.id)}']")
      end
    end
  end
end

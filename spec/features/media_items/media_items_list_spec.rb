require "spec_helper"

feature "Media items list" do
  scenario "when not signed in" do
    visit media_items_path
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end

  context "when signed in" do
    let(:user) { FactoryGirl.create :user }
    let(:second_user) { FactoryGirl.create :user }
    let(:media_items) { create_items options: { user: user } }

    context "when another users items are unpublished" do
      let(:second_user_items) { create_items options: { user: second_user }}

      scenario "listing items" do
        signin user.email
        media_items
        second_user_items
        visit media_items_path
        media_items.each do |media_item|
          expect(page).to have_css("[@id='media-item-#{media_item.id}']")
        end
        second_user_items.each do |media_item|
          expect(page).not_to have_css("[@id='media-item-#{media_item.id}']")
        end
      end
    end
    
    context "when another user has published items" do
      let(:second_user_items) { create_items options: { user: second_user, published: true } }
      
      scenario "listing items" do
        media_items
        second_user_items
        signin user.email
        visit media_items_path
        media_items.each do |media_item|
          expect(page).to have_css("[@id='media-item-#{media_item.id}']")
        end
        second_user_items.each do |media_item|
          expect(page).to have_css("[@id='media-item-#{media_item.id}']")
        end
      end
      
      scenario "media item search" do
        media_items
        second_user_items
        signin user.email
        visit media_items_path
        search_item = media_items.first
        [:title, :description, :user_name].each do |by|
          search_result_count = media_items.inject(0) do |sum, item|
            sum += 1 if item.send(by).include? search_item.send(by)
            sum
          end
          fill_in "q_#{by.to_s}_cont", with: search_item.send(by)
          click_button "Search"
          expect(page).to have_css("#media-item-#{search_item.id}")
          expect(page).to have_selector("tbody > tr", count: search_result_count)
          visit media_items_path
        end
      end
      
    end
  end

end

module Features
  module MediaItemHelpers
    def create_items(options:, per_type: 1)
      [:video_item, :link_item, :image_item].map { |type|
        per_type.times.map {
          FactoryGirl.create type, options
        }
      }.flatten
    end

    def expect_item_details page
      expect(page).to have_content(item.user.name)
      expect(page).to have_content(item.title)
      expect(page).to have_content(item.description)
      expect(page).to have_content(item.created_at)
      expect(page).to have_content(item.updated_at)    
    end

    def expect_edit_fields page
      expect(page).to have_content("Title")
      expect(page).to have_content("Description")
      expect(page).to have_css("input#video_item_title")
      expect(page).to have_css("textarea#video_item_description")
    end
  end
end

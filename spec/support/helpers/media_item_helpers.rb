module Features
  module MediaItemHelpers
    def create_items(options:, per_type: 1)
      [:video_item, :link_item, :image_item].map { |type|
        per_type.times.map {
          FactoryGirl.create type, options
        }
      }.flatten
    end
  end
end

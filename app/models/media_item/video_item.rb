class VideoItem < MediaItem

  has_one :link, foreign_key: :media_item_id

end

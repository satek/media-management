class LinkItem < MediaItem

  has_many :links, foreign_key: :media_item_id

  def has_links?
    links.any?
  end

end

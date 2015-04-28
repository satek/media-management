class ImageItem < MediaItem

  has_many :images

  def has_links?
    false
  end

  def has_images?
    images.any?   
  end

end

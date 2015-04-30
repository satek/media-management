class ImageItem < MediaItem

  has_many :images

  def has_images?
    images.any?
  end

end

class Link < ActiveRecord::Base
  
  validates :media_item_id, :url, presence: true
  validate :url_protocol_present
  validate :video_item_has_only_one_link

  belongs_to :media_item

  private

  def url_protocol_present
    errors.add(:url, "Protocol must be present") unless url.start_with? "http"
  end

  def video_item_has_only_one_link
    return if !media_item
    return if media_item.type != 'VideoItem' or !media_item.link
    errors.add(:base, "Video media can only have one link")
  end

  def does_not_belong_to_image_item
    return if media_item.type != 'ImageItem'
    errors.add(:base, "Image item cannot have a link")
  end

end

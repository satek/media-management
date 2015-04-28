class MediaItem < ActiveRecord::Base

  validates :title, :description, :user_id, :type, presence: true
  validate :type_correctness

  belongs_to :user

  def self.type_descriptions
    {
      "Video" => "VideoItem",
      "Web Link" => "LinkItem",
      "Image" => "ImageItem"
    }
  end

  def types
    %W(VideoItem LinkItem ImageItem)
  end

  def is_video?
    type == 'VideoItem'
  end

  def is_link?
    type == 'LinkItem'
  end

  def is_image?
    type == 'ImageItem'
  end

  def has_link?
    links.any? 
  end

  private

  def type_correctness
    errors.add(:type, "is not acceptable") unless types.include? type
  end

end

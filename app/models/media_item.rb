class MediaItem < ActiveRecord::Base

  validates :title, :description, presence: true
  validate :type_correctness

  def types
    %W(VideoItem LinkItem ImageItem)
  end

  private

  def type_correctness
    errors.add(:type, "Type is not acceptable") unless types.include? type
  end

end

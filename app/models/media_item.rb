class MediaItem < ActiveRecord::Base

  validates :title, :description, :user_id, presence: true
  validate :type_correctness

  belongs_to :user

  def types
    %W(VideoItem LinkItem ImageItem)
  end

  private

  def type_correctness
    errors.add(:type, "is not acceptable") unless types.include? type
  end

end
